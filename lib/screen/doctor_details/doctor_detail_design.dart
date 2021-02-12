import 'package:flutter/material.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter.dart';

class DoctorDetailDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 0.5,
          child: CustomPaint(
            painter: CurvePainter(),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 8.4,
          left: MediaQuery.of(context).size.width / 7,
          child: Center(
            child: Text(
              "Consulting Doctor",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 5.1,
            left: MediaQuery.of(context).size.width / 5.1,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'images/ConsultingDoc.png',
                    height: 210,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
