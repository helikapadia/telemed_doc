import 'dart:async';

import 'package:telemed_doc/util/constant.dart';

mixin ForgotPasswordValidators {
  StreamTransformer<String, String> emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String emailValidate =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailValidate);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError(EMAIL_ERROR);
    }
  });
}
