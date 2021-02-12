import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, FORGOT_PASSWORD_ROUTE);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
