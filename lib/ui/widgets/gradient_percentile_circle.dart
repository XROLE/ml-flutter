import 'package:flutter/material.dart';

class GradientPercentCircle extends StatelessWidget {
  final double percent; 
  final double size;
  final double stroke;

  const GradientPercentCircle({
    super.key,
    required this.percent,
    this.size = 140,
    this.stroke = 12,
  });

  @override
  Widget build(BuildContext context) {
    final target = (percent.clamp(0, 100)) / 100.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: const Duration(seconds: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return CustomPaint(
          painter: _CirclePainter(value, stroke),
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Text("${(value * 100).round()}%"),
            ),
          ),
        );
      },
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double value; // 0..1
  final double stroke;

  _CirclePainter(this.value, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;

    // Background ring
    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE5E7EB);
    canvas.drawCircle(center, radius, bg);

    // Gradient progress ring
    final sweep = 2 * 3.1415926535 * value;
    final startAngle = -3.1415926535 / 2; // start at top (12 o’clock)
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [Color(0xFF22C55E), Color(0xFF3B82F6)],
      ).createShader(rect);

    final rectArc = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rectArc, startAngle, sweep, false, fg);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.stroke != stroke;
}
