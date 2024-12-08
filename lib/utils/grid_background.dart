import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity,height: double.infinity,
      color: Colors.black, // Black background
      child: CustomPaint(
        painter: GridPainter(),

      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2) // Thin grid lines with some transparency
      ..strokeWidth = 0.5; // Thin lines

    // Draw vertical grid lines
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Draw horizontal grid lines
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}