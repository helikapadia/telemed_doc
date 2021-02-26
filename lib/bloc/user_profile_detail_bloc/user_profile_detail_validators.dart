import 'dart:async';

import 'package:telemed_doc/util/constant.dart';

mixin UserProfileDetailValidators {
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
  StreamTransformer<String, String> fullNameValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (fullName, sink) {
    if (fullName.length > 1) {
      sink.add(fullName);
    } else {
      sink.addError(FULL_NAME_ERROR);
    }
  });

  StreamTransformer<String, String> genderValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (gender, sink) {
    if (gender.length > 1) {
      sink.add(gender);
    } else {
      sink.addError(GENDER_ERROR);
    }
  });
  StreamTransformer<String, String> phoneNumberValidators =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (phoneNumber, sink) {
    String phoneValidate = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(phoneValidate);
    if (regExp.hasMatch(phoneNumber)) {
      sink.add(phoneNumber);
    } else {
      sink.addError(PHONE_NUMBER_ERROR);
    }
  });

  StreamTransformer<String, String> dateOfBirthValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (dateOfBirth, sink) {
    if (dateOfBirth.length == 10) {
      sink.add(dateOfBirth);
    } else {
      sink.addError(DATE_OF_BIRTH_ERROR);
    }
  });
}
