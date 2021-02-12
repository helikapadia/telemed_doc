import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class CurvePainterHome extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      ..style = PaintingStyle.fill;
    paint.shader = LinearGradient(
      colors: [
        BG_BLUE1,
        BG_BLUE2,
        BG_BLUE3,
        BG_BLUE4,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ).createShader(rect);
    var path = Path()
      ..moveTo(0, size.height*0.75)
      ..quadraticBezierTo(size.width/3 +50, size.height / 0.859, size.width -0.2, size.height * 0.70)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}