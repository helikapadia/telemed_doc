import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class CurvePainterDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 250),
      child: Positioned(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: MediaQuery.of(context).size.height / 6.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.center,
              colors: [
                BG_BLUE4,
                BG_BLUE3
              ]
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
