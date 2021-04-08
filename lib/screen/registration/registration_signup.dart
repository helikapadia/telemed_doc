import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class RegistrationSignUp extends StatelessWidget {
  final RegistrationBloc registrationBloc;

  const RegistrationSignUp({Key key, @required this.registrationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: registrationBloc.submitCheck,
        builder: (context, snapshot) {
          bool isEnabled;
          if (snapshot.hasData) {
            isEnabled = snapshot.data &&
                registrationBloc.passwordValue ==
                    registrationBloc.confirmPasswordValue;
          } else {
            isEnabled = false;
          }
          return TextButton(
              onPressed: isEnabled
                  ? () {
                      registrationBloc.registerUser(context);
                    }
                  : null,
              child: Container(
                width: MediaQuery.of(context).size.width - 65,
                height: 50,
                //padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  color: isEnabled ? BUTTON_BLUE : Colors.grey,
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ));
        });
  }
}
