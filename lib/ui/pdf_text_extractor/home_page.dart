import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ml_flutter/constants/app_colors.dart';
import 'package:ml_flutter/ui/pdf_text_extractor/pdf_text_extraction_page.dart';
import 'package:ml_flutter/ui/widgets/action_button.dart';
import 'package:ml_flutter/ui/widgets/custom_text_input';
import 'package:ml_flutter/ui/widgets/custom_text_input_2.dart';
import 'package:ml_flutter/ui/widgets/padded_container.dart';
import 'package:ml_flutter/ui/widgets/unfocus_widget.dart';
import 'package:ml_flutter/util/app_flush_bar.dart';
import 'package:ml_flutter/util/helper.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

List<String> pdfTypes = ["Locked PDF", "Plain PDF"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? pickedFile;
  String? fileName;
  String doc = "";
  String selectedPdfType = pdfTypes[0];
  String address = "";

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File? file = File(result.files.single.path!);

      setState(() {
        fileName = result.files.single.name;
        pickedFile = file;
      });
    } else {
      setState(() {
        fileName = null;
      });
    }
  }

  Future<void> extractDoc({required File file, String? password}) async {
    final fileBytes = file.readAsBytesSync();
    final document = PdfDocument(inputBytes: fileBytes, password: password);
    String extractedDoc = "";

    for (int i = 0; i < document.pages.count; i++) {
      extractedDoc += PdfTextExtractor(document).extractText(startPageIndex: i);
      extractedDoc += " ";
    }

    String? extractedAddress = Helper().extractAddress(extractedDoc);
    setState(() {
      doc = extractedDoc;
      address = extractedAddress ?? "";
    });

    print("This is the extracted doc ======================> $extractedDoc");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return UnfocusWidget(
      child: Scaffold(
        body: PaddedContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: size.height * .075),
                  Row(
                    children: [
                      Text(
                        "Enter Address",
                        style: TextStyle(fontSize: size.height * .02),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .02),
                  CustomTextInput2(
                    labelText: "Address",
                    controller: addressController,
                  ),
                  SizedBox(height: size.height * .045),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPdfType,
                        style: TextStyle(fontSize: size.height * .02),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: size.width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .08,
                                  vertical: size.height * .04,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        Text(
                                          "Select PDF Type",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * .024,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close, weight: 30),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * .045),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedPdfType = pdfTypes[0];
                                        });
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.file_open_outlined),
                                        title: Text(
                                          pdfTypes[0],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * .018,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black.withValues(
                                            alpha: .3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .015),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedPdfType = pdfTypes[1];
                                        });
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.file_open_outlined),
                                        title: Text(
                                          pdfTypes[1],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * .018,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black.withValues(
                                            alpha: .3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .015),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .003),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.all(size.width * .05),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(size.height * .003),
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await pickFile();
                            },
                            icon: Icon(Icons.file_upload, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: size.height * .015),
                        Text(
                          fileName == null
                              ? "Upload $selectedPdfType"
                              : fileName!,
                          style: TextStyle(fontSize: size.height * .015),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .025),
                  if (selectedPdfType == pdfTypes[0])
                    CustomTextInput(
                      icon: Icons.key,
                      controller: passwordController,
                    ),
                ],
              ),

              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.richBlue),
                      borderRadius: BorderRadius.circular(size.height * .05),
                    ),
                    child: ActionButton(
                      title: "Match Address",
                      onTap: () async {
                        String password = passwordController.text;

                        if (pickedFile == null) {
                          AppFlushBar().showError(
                            message: "Upload a PDF to continue",
                            context: context,
                          );
                        } else if (addressController.text.isEmpty) {
                          AppFlushBar().showError(
                            message: "Enter address to proceed",
                            context: context,
                          );
                        } else {
                          if (selectedPdfType == pdfTypes[0]) {
                            await extractDoc(
                              file: pickedFile!,
                              password: password,
                            );

                            if (password.isEmpty) {
                              AppFlushBar().showError(
                                message: "Kindly provide Password to continue",
                                context: context,
                              );
                            } else {
                              double matchPercentage = Helper()
                                  .hybridStringMatch(
                                    address,
                                    addressController.text,
                                  );
                              print(
                                "matchPercentage ========================> $matchPercentage",
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PdfTextExtractionPage(
                                      doc: doc,
                                      fileName: fileName ?? "",
                                      address: address,
                                      matchPercentage: matchPercentage,
                                    );
                                  },
                                ),
                              );
                            }
                          } else {
                            await extractDoc(file: pickedFile!);
                            double matchPercentage = Helper().hybridStringMatch(
                              address,
                              addressController.text,
                            );
                            print(
                              "matchPercentage ========================> $matchPercentage",
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PdfTextExtractionPage(
                                    doc: doc,
                                    fileName: fileName ?? "",
                                    address: address,
                                    matchPercentage: matchPercentage,
                                  );
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),

                  SizedBox(height: size.height * .06),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
