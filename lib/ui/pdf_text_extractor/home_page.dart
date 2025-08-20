import 'package:flutter/material.dart';
import 'package:ml_flutter/constants/app_colors.dart';
import 'package:ml_flutter/ui/pdf_text_extractor/pdf_text_extraction_page.dart';
import 'package:ml_flutter/ui/widgets/action_button.dart';
import 'package:ml_flutter/ui/widgets/custom_text_input';
import 'package:ml_flutter/ui/widgets/padded_container.dart';

List<String> pdfTypes = ["Locked PDF", "Plain PDF"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPdfType = pdfTypes[0];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PaddedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: size.height * .075),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedPdfType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * .02,
                      ),
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
SizedBox(height: size.height * .025),
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(size.width * .05),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.height * .025),
                        decoration: BoxDecoration(
                        color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Icon(Icons.file_upload, color: Colors.white,),
                      ),
                      SizedBox(height: size.height * .015),
                      Text("Upload $selectedPdfType",  style: TextStyle(
                        fontSize: size.height * .02,
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: size.height * .025),
                CustomTextInput(icon: Icons.key,)
              ],
            ),

            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.richBlue),
                    borderRadius: BorderRadius.circular(size.height * .05),
                  ),
                  child: ActionButton(title: "Extract Address", onTap: () {}),
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
