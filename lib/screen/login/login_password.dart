import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/login_bloc/login_bloc.dart';

class LoginPassword extends StatelessWidget {
  final LoginBloc loginBloc;

  const LoginPassword({Key key, @required this.loginBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: loginBloc.password,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  enableSuggestions: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  obscureText: true,
                  onChanged: (value) {
                    loginBloc.passwordChanged(value);
                  },
                  validator: (value) {
                    if (value.length < 3) {
                      return 'Minimum 8 characters, one alphanumberic and one uppercase letter';
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon:
                        !snapshot.hasError && loginBloc.passwordValue != null
                            ? Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : null,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
