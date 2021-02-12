import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';

class RegistrationName extends StatelessWidget {
  final RegistrationBloc registrationBloc;
  final FocusNode fullNameFocusNode;
  final FocusNode genderFocusNode;

  const RegistrationName({Key key,@required this.registrationBloc,@required this.fullNameFocusNode, @required this.genderFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: registrationBloc.fullName,
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
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                focusNode: fullNameFocusNode,
                onChanged: (value){
                  registrationBloc?.fullNameChanged(value);
                },
                onFieldSubmitted: (value){
                  FocusScope.of(context).requestFocus(genderFocusNode);
                },
                decoration: InputDecoration(
                  suffixIcon: !snapshot.hasError &&
                      registrationBloc.fullNameValue != null
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                      : null,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Full Name',
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
