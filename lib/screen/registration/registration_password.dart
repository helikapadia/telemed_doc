import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';

class RegistrationPassword extends StatelessWidget {
  final RegistrationBloc registrationBloc;
  final FocusNode passwordFocusNode, confirmPasswordFocusNode;

  const RegistrationPassword(
      {Key key,
      @required this.registrationBloc,
      @required this.passwordFocusNode,
      @required this.confirmPasswordFocusNode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: registrationBloc.password,
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
                  obscureText: true,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    registrationBloc?.passwordChanged(value);
                  },
                  focusNode: passwordFocusNode,
                  onFieldSubmitted: (value){
                    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                  },
                  decoration: InputDecoration(
                    suffixIcon: !snapshot.hasError &&
                            registrationBloc.passwordValue != null
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
    ;
  }
}
