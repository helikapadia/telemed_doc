import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginTermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'By signing in, you accept our',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, TERMS_CONDITIONS_ROUTE);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 3, right: 8),
            child: Text('Terms and Conditions',
              style: TextStyle(
                  color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.bold
              ),),
          ),
        ),
      ],
    );
  }
}