import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeProfile extends StatefulWidget {
  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, PROFILE_DETAIL);
            },
            child: Text(
              'View Your profile',
              style: TextStyle(
                  fontFamily: 'Poppins', color: FONT_BLUE, fontSize: 14),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/View Profile.png',
                height: 178,
                width: 166,
              ),
            ],
          )
        ],
      ),
    );
  }
}
