import 'package:flutter/material.dart';
import 'package:ml_flutter/constants/app_colors.dart';
import 'package:ml_flutter/ui/pdf_text_extractor/pdf_text_extraction_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(Icons.file_open_outlined),
                                title: Text(
                                  "Locked PDF",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * .018,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black.withValues(alpha: .3),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * .015),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PdfTextExtractionPage(),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(Icons.file_open_outlined),
                                title: Text(
                                  "Plain PDF",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * .018,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black.withValues(alpha: .3),
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
                icon: Icon(Icons.upload, size: size.height * .06),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
