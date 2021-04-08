import 'package:flutter/material.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter.dart';

class AddFamilyScreenDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width / 0.5,
          child: CustomPaint(
            painter: CurvePainter(),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 7.4,
          left: MediaQuery.of(context).size.width / 3.8,
          child: Center(
            child: Text(
              " Add Family Member",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
      ],
    );
  }
}
