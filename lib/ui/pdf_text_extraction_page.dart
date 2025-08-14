import 'package:flutter/material.dart';
import 'package:ml_flutter/constants/app_colors.dart';
import 'package:ml_flutter/ui/widget/action_button.dart';
import 'package:ml_flutter/ui/widget/padded_container.dart';

class PdfTextExtractionPage extends StatefulWidget {
  const PdfTextExtractionPage({super.key});

  @override
  State<PdfTextExtractionPage> createState() => _PdfTextExtractionPageState();
}

class _PdfTextExtractionPageState extends State<PdfTextExtractionPage> {
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
                SizedBox(height: size.height * .1),
                Container(
                  height: size.height * .14,
                  decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .03),
                      ListTile(
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
                          "2023 Bank statement for pdf lovers",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility, color: Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                SizedBox(height: size.height * .03),
Center(child: Container(
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.richBlue),borderRadius: BorderRadius.circular(size.height * .05)
  ),
  child: IconButton(onPressed: (){}, icon: Icon(Icons.add, size: size.height * .06,))),),
                SizedBox(height: size.height * .06),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
