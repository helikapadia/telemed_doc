import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_BLUE2,
        title: Text(
          'PROFILE',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HOME_SCREEN, (route) => false);
              }),
        ),
      ),
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Card(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PROFILE_SCREEN);
                      },
                      child: Text(
                        'Personal Information',
                        style:
                            TextStyle(fontFamily: 'Poppins', color: FONT_BLUE),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Card(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DOCTOR_DETAIL_PROFILE_SCREEN);
                    },
                    child: Text(
                      'Consulting Doctor Information',
                      style: TextStyle(fontFamily: 'Poppins', color: FONT_BLUE),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                child: Card(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DAILY_MEDICINE_PROFILE_SCREEN);
                    },
                    child: Text(
                      'Daily Medicine Information',
                      style: TextStyle(fontFamily: 'Poppins', color: FONT_BLUE),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Card(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EMERGENCY_PROFILE_SCREEN);
                    },
                    child: Text(
                      'Emergency Contact Information',
                      style: TextStyle(fontFamily: 'Poppins', color: FONT_BLUE),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
