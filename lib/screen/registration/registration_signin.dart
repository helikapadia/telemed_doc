import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class RegistrationSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already have an account?',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 18),
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, LOGIN_ROUTE);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 3, right: 8),
            child: Text('Sign In',
            style: TextStyle(
                color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 18
            ),),
          ),
        ),
      ],
    );
  }
}
