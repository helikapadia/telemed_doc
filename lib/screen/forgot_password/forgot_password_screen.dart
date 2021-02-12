import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:telemed_doc/screen/forgot_password/forgot_password_email.dart';
import 'package:telemed_doc/screen/forgot_password/forgot_password_next_button.dart';
import 'package:telemed_doc/util/constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: Image.asset(
                  'images/Logo.png',
                  height: 50,
                )),
                Text(
                  'TeleMed Doc',
                  style: TextStyle(
                      color: FONT_BLUE,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: FONT_BLUE,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Center(
                    child: Text(
                      'Please enter your email address and ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Center(
                    child: Text(
                      'we will send you a reset email.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ForgotPasswordEmail(
                  forgotPasswordBloc: forgotPasswordBloc,
                ),
                const SizedBox(
                  height: 30,
                ),
                ForgotPasswordNext(
                  forgotPasswordBloc: forgotPasswordBloc,
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
