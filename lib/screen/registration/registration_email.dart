import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';

class RegistrationEmail extends StatelessWidget {
  final RegistrationBloc registrationBloc;
  final FocusNode emailFocusNode;

  const RegistrationEmail({Key key, @required this.registrationBloc,@required this.emailFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: registrationBloc.email,
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
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  focusNode: emailFocusNode,
                  onChanged: (value) {
                    registrationBloc?.emailChanged(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: !snapshot.hasError &&
                            registrationBloc.emailValue != null
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
