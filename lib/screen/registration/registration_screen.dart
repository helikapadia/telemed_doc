import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';
import 'package:telemed_doc/screen/registration/registration_confirm_password.dart';
import 'package:telemed_doc/screen/registration/registration_email.dart';
import 'package:telemed_doc/screen/registration/registration_gender.dart';
import 'package:telemed_doc/screen/registration/registration_name.dart';
import 'package:telemed_doc/screen/registration/registration_password.dart';
import 'package:telemed_doc/screen/registration/registration_signin.dart';
import 'package:telemed_doc/screen/registration/registration_signup.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationBloc registrationBloc = RegistrationBloc();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode genderFoucsNode = FocusNode();

  @override
  void dispose() {
    registrationBloc?.dispose();
    fullNameFocusNode?.dispose();
    passwordFocusNode?.dispose();
    confirmPasswordFocusNode?.dispose();
    genderFoucsNode?.dispose();
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
                // mainAxisSize: MainAxisSize.min,
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
                    'Sign Up',
                    style: TextStyle(
                        color: FONT_BLUE,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RegistrationSignIn(),
                  const SizedBox(
                    height: 10,
                  ),
                  RegistrationName(
                    fullNameFocusNode: fullNameFocusNode,
                    registrationBloc: registrationBloc,
                    genderFocusNode: genderFoucsNode,
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  RegistrationEmail(
                    registrationBloc: registrationBloc,
                    emailFocusNode: emailFocusNode,
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  RegistrationGender(
                    registrationBloc: registrationBloc,
                    genderFocusNode: genderFoucsNode,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  RegistrationPassword(
                    registrationBloc: registrationBloc,
                    passwordFocusNode: passwordFocusNode,
                    confirmPasswordFocusNode: confirmPasswordFocusNode,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  RegistrationConfirmPassword(
                    registrationBloc: registrationBloc,
                    focusNode: confirmPasswordFocusNode,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RegistrationSignUp(
                    registrationBloc: registrationBloc,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
