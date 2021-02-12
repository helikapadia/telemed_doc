import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/login_bloc/login_bloc.dart';

class LoginEmail extends StatelessWidget {
  final LoginBloc loginBloc;
  final TextEditingController emailController;


  const LoginEmail({Key key,@required this.loginBloc,@required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: loginBloc.email,
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
                controller: emailController,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (value){
                  loginBloc.emailChanged(value);
                },
                decoration: InputDecoration(
                  suffixIcon: !snapshot.hasError && loginBloc.emailValue != null
                  ? Icon(Icons.check, color: Colors.green,):null,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
