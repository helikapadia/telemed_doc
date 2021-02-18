import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';
import 'package:telemed_doc/util/app_helper.dart';

class RegistrationConfirmPassword extends StatelessWidget {
  final RegistrationBloc registrationBloc;
  final FocusNode focusNode;

  const RegistrationConfirmPassword(
      {Key key, @required this.registrationBloc, @required this.focusNode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: registrationBloc.confirmPassword,
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
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  obscureText: true,
                  focusNode: focusNode,
                  onChanged: (value) {
                    registrationBloc?.confirmPasswordChanged(value);
                  },
                  onFieldSubmitted: (value) {
                    hideKeyboard(context);
                  },
                  validator: (value) {
                    if (value.length < 3) {
                      return 'Minimum 8 characters, one alphanumberic and one uppercase letter';
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: !snapshot.hasError &&
                            registrationBloc.confirmPasswordValue != null &&
                            registrationBloc.confirmPasswordValue ==
                                registrationBloc.passwordValue
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    fillColor: Colors.white,
                    hintText: 'Confirm Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
