import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeScreenDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
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
          child: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }),
            ),
            backgroundColor: BG_BLUE2,
          ),
        ),),
        Positioned(
          top: MediaQuery.of(context).size.height / 7.6,
          left: 20,
          child: Text(
            "TeleMed Doc",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 4.3,
            left: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Access To Health Care,',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  'Anytime, Anywhere',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            )),
        Positioned(
          left: 220,
            top: 80,
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'images/Doctor.png',
              height: 300,
              width: 160,
            ),
          ],
        )),
        // Positioned(
        //     top: 200,
        //     child: Column(
        //   children: [
        //     HomeSearch(),
        //   ],
        // ))
      ],
    );
  }
}
