import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ml_flutter/constants/app_colors.dart';
import 'package:ml_flutter/ui/widgets/padded_container.dart';
import 'package:ml_flutter/util/helper.dart';
import 'package:pdf_text/pdf_text.dart';

class PdfTextExtractionPage extends StatefulWidget {
  const PdfTextExtractionPage({super.key});

  @override
  State<PdfTextExtractionPage> createState() => _PdfTextExtractionPageState();
}

class _PdfTextExtractionPageState extends State<PdfTextExtractionPage> {
  File? pickedFile;
  String? fileName;
  String doc = "";

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File? file = File(result.files.single.path!);
      PDFDoc pdfDoc = await PDFDoc.fromFile(file);
      String extractedText = await pdfDoc.text;
      setState(() {
        fileName = result.files.single.name;
        pickedFile = file;
        doc = extractedText;
      });
    } else {
      setState(() {
        fileName = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

      String? address = Helper().extractAddress(doc);
      

    return Scaffold(
      body: PaddedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: size.height * .06),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                  ],
                ),
                SizedBox(height: size.height * .017),
                Column(
                  children: [
                    if(address != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address : ",
                          style: TextStyle(
                            fontSize: size.height * 0.017,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          address,
                          style: TextStyle(fontSize: size.height * 0.017),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * .015),
                  ],
                ),
                Container(
                  height: size.height * .14,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .03),
                      pickedFile == null
                          ? Center(
                            child: Text(
                              "No file loaded",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * .019,
                              ),
                            ),
                          )
                          : ListTile(
                            leading: Container(
                              height: size.height * .06,
                              width: size.height * .06,
                              decoration: BoxDecoration(
                                color: Colors.amber[700],
                                borderRadius: BorderRadius.circular(
                                  size.height * .03,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "B",
                                  style: TextStyle(
                                    fontSize: size.height * 0.024,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Bank statement",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              fileName ?? "",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .015),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .04,
                    vertical: size.height * .02,
                  ),
                  height: size.height * .45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(child: Text(doc)),
                ),
              ],
            ),

            Column(
              children: [
                SizedBox(height: size.height * .03),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.richBlue),
                      borderRadius: BorderRadius.circular(size.height * .05),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await pickFile();
                      },
                      icon: Icon(Icons.add, size: size.height * .06),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .06),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
