import 'package:flutter/material.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter.dart';

class EmergencyScreenDesign extends StatelessWidget {
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
          top: MediaQuery.of(context).size.height / 7.4,
          left: MediaQuery.of(context).size.width / 4.3,
          child: Center(
            child: Text(
              "TeleMed Doc",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 3.7,
            left: MediaQuery.of(context).size.width / 4.5,
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Incase of Emergency,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    'Add a Contact for Help',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '(Down Below)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Center(
                      child: Image.asset(
                    'images/Element of Emergency.png',
                    height: 80,
                  )),
                ],
              ),
            ))
      ],
    );
  }
}
