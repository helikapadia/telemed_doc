import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class EmergencyMedical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: LIGHT_BLUE,
      textColor: Colors.white,
      onPressed: (){
        //Navigator.pushNamed(context, RESET_CODE_SCREEN);
      },
      child: Text(
        'Medical Emergency',
        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      // disabledColor: Colors.grey,
      // disabledTextColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
    );
  }
}
