import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Dont have an account?',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 18),
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, REGISTER_ROUTE);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 3, right: 8),
            child: Text('Sign Up',
              style: TextStyle(
                  color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 18
              ),),
          ),
        ),
      ],
    );
  }
}
