import 'package:flutter/material.dart';

class PercentCircle extends StatelessWidget {
  final double percent; 
  final double size;
  final double stroke;
  final Color color;
  final Color bgColor;

  const PercentCircle({
    super.key,
    required this.percent,
    this.size = 120,
    this.stroke = 10,
    this.color = const Color(0xFF3B82F6),
    this.bgColor = const Color(0xFFE5E7EB),
  });

  @override
  Widget build(BuildContext context) {
    final target = (percent.clamp(0, 100)) / 100.0;

    return Container(
      color: Colors.red,
      height: 200,
      width: 200,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: target),
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: stroke,
                color: color,
                backgroundColor: bgColor,
                strokeCap: StrokeCap.round,
              ),
              Text("${(value * 100).round()}%"),
            ],
          );
        },
      ),
    );
  }
}
