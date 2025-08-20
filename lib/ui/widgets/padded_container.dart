import 'package:flutter/material.dart';

class PaddedContainer extends StatelessWidget {
  final Widget child;
  const PaddedContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: child,
    );
  }
}
