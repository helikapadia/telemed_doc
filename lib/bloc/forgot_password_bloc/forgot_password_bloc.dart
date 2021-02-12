import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/forgot_password_bloc/forgot_password_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class ForgotPasswordBloc with ForgotPasswordValidators {
  final _emailController = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>.seeded(false);

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<bool> get progress => _showProgress.stream;

  String get emailValue => _emailController.stream.value;
  bool get progressBarValue => _showProgress.stream.value;

  Function(String) get emailChanged => _emailController.sink.add;
  Function(bool) get showProgress => _showProgress.sink.add;

  Stream<bool> get enableForgotPasswordRequest => email.map((e) => true);

  void requestPasswordReset(BuildContext context) {
    AppHelper.checkInternetConnection().then((isAvailable) {
      if (isAvailable) {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailValue)
            .then((authResult) {
          Navigator.pop(context, CHECK_YOUR_MAIL_FOR_PASSWORD_RESET);
          showProgress(false);
        }).catchError((errors) {
          showMessageDialog(errors.message, context);
        });
      } else {
        showProgress(false);
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
      }
    });
  }

  void dispose() {
    _emailController?.close();
    _showProgress?.close();
  }
}
