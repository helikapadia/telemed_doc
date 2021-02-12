import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/forgot_password_bloc/forgot_password_bloc.dart';

class ForgotPasswordEmail extends StatelessWidget {
  final ForgotPasswordBloc forgotPasswordBloc;

  const ForgotPasswordEmail({Key key, @required this.forgotPasswordBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: forgotPasswordBloc.email,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    forgotPasswordBloc.emailChanged(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Email Address',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
