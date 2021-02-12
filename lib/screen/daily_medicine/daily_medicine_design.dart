import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.3,
          width: MediaQuery.of(context).size.width / 0.2,
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: [
                    BG_BLUE1,
                    BG_BLUE2,
                    BG_BLUE3,
                    BG_BLUE4,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 9.7,
          left: MediaQuery.of(context).size.width / 4.5,
          child: Column(
            children: [
              Text(
                "Daily Medicine",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
