import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/login_bloc/login_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginSignIn extends StatelessWidget {
  final LoginBloc loginBloc;

  const LoginSignIn({Key key, @required this.loginBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: loginBloc.submitCheck,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;

          return TextButton(
              onPressed: isEnabled
                  ? () {
                      loginBloc.loginUser(context);
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
                      'Sign In',
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
