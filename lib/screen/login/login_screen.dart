import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/login_bloc/login_bloc.dart';
import 'package:telemed_doc/screen/login/login_email.dart';
import 'package:telemed_doc/screen/login/login_password.dart';
import 'package:telemed_doc/screen/login/login_remember_me.dart';
import 'package:telemed_doc/screen/login/login_sign_in.dart';
import 'package:telemed_doc/screen/login/login_sign_up.dart';
import 'package:telemed_doc/screen/login/login_terms_and_conditions.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    loginBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
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
                    'Sign In',
                    style: TextStyle(
                        color: FONT_BLUE,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LoginSignUp(),
                  const SizedBox(
                    height: 30,
                  ),
                  LoginEmail(
                    loginBloc: loginBloc,
                    emailController: emailController,
                  ),

                  LoginPassword(
                    loginBloc: loginBloc,
                  ),

                  LoginRememberMe(),
                  //LoginForgotPassword(),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginSignIn(
                    loginBloc: loginBloc,
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  LoginTermsAndConditions(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
