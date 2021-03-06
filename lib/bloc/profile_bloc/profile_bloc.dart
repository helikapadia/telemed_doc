import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class ProfileBloc with ProfileValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _fullName = BehaviorSubject<String>();
  final _modalFullName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _modalEmail = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _modalPhoneNumber = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _modalAge = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _bloodGroup = BehaviorSubject<String>();
  final _allergy = BehaviorSubject<String>();
  final _modalAllergy = BehaviorSubject<String>();
  final _trouble = BehaviorSubject<String>();
  final _modalTrouble = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get fullName => _fullName.stream.transform(fullNameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phoneNumber => _phoneNumber.stream;
  Stream<String> get modalFullName =>
      _modalFullName.stream.transform(fullNameValidator);
  Stream<String> get modalEmail => _modalEmail.stream.transform(emailValidator);
  Stream<String> get modalPhoneNumber =>
      _modalPhoneNumber.stream.transform(phoneNumberValidators);
  Stream<String> get gender => _gender.stream.transform(genderValidator);
  Stream<String> get age => _age.stream;
  Stream<String> get modalAge => _modalAge.stream;
  Stream<String> get dob => _dob.stream;
  Stream<String> get bloodGroup => _bloodGroup.stream;
  Stream<String> get allergy => _allergy.stream;
  Stream<String> get modalAllergy => _modalAllergy.stream;
  Stream<String> get trouble => _trouble.stream;
  Stream<String> get modalTrouble => _modalTrouble.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get fullNameValue => _fullName.stream.value;
  String get emailValue => _email.stream.value;
  String get phoneNumberValue => _phoneNumber.stream.value;
  String get modalFullNameValue => _modalFullName.stream.value;
  String get modalEmailValue => _modalEmail.stream.value;
  String get modalPhoneNumberValue => _modalPhoneNumber.stream.value;
  String get genderValue => _gender.stream.value;
  String get ageValue => _age.stream.value;
  String get modalAgeValue => _modalAge.stream.value;
  String get dobValue => _dob.stream.value;
  String get bloodGroupValue => _bloodGroup.stream.value;
  String get allergyValue => _allergy.stream.value;
  String get modalAllergyValue => _modalAllergy.stream.value;
  String get troubleValue => _trouble.stream.value;
  String get modalTroubleValue => _modalTrouble.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get fullNameChanged => _fullName.sink.add;
  Function(String) get emailChanged => _email.sink.add;
  Function(String) get phoneNumberChanged => _phoneNumber.sink.add;
  Function(String) get modalFullNameChanged => _modalFullName.sink.add;
  Function(String) get modalEmailChanged => _modalEmail.sink.add;
  Function(String) get modalPhoneNumberChanged => _modalPhoneNumber.sink.add;
  Function(String) get genderChanged => _gender.sink.add;
  Function(String) get changeAge => _age.sink.add;
  Function(String) get modalAgeChanged => _modalAge.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeBloodGroup => _bloodGroup.sink.add;
  Function(String) get changeAllergy => _allergy.sink.add;
  Function(String) get modalAllergyChanged => _modalAllergy.sink.add;
  Function(String) get changeTrouble => _trouble.sink.add;
  Function(String) get modalTroubleChanged => _modalTrouble.sink.add;

  Stream<bool> get enableFullNameSubmitCheck => _fullName.map((event) => true);
  Stream<bool> get enableEmailSubmitCheck => _email.map((event) => true);
  Stream<bool> get enableAgeSubmitCheck => _age.map((event) => true);
  Stream<bool> get enablePhoneNumberSubmitCheck =>
      _phoneNumber.map((event) => true);
  Stream<bool> get enableAllergySubmitCheck => _allergy.map((event) => true);
  Stream<bool> get enableTroubleSubmitCheck => _trouble.map((event) => true);

  void getData() {
    AppPreference.getStringF(EMAIL_KEY).then((value) {
      emailChanged(value);
    }).catchError((error) {
      emailChanged("");
    });

    AppPreference.getStringF(FULL_NAME_KEY).then((value) {
      fullNameChanged(value);
    }).catchError((error) {
      fullNameChanged("");
    });

    AppPreference.getStringF(AGE_KEY).then((value) {
      changeAge(value);
    }).catchError((error) {
      changeAge("");
    });

    AppPreference.getStringF(GENDER_KEY).then((value) {
      genderChanged(value);
    });

    AppPreference.getStringF(PHONE_NUMBER_KEY).then((value) {
      phoneNumberChanged(value);
    }).catchError((error) {
      phoneNumberChanged("");
    });

    AppPreference.getStringF(BLOOD_GROUP_KEY).then((value) {
      changeBloodGroup(value);
    });

    AppPreference.getStringF(DOB_KEY).then((value) {
      changeDob(value);
    });

    AppPreference.getStringF(ALLERGIES_KEY).then((value) {
      changeAllergy(value);
    }).catchError((error) {
      changeAllergy("");
    });

    AppPreference.getStringF(TROUBLES_KEY).then((value) {
      changeTrouble(value);
    }).catchError((error) {
      changeTrouble("");
    });
  }

  void updateEmail(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({EMAIL_KEY: modalEmailValue}).then((value) {
          showProgress(false);
          emailChanged(modalEmailValue);
          modalEmailChanged("");
          AppPreference.setString(EMAIL_KEY, emailValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void updateFullName(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({FULL_NAME_KEY: modalFullNameValue}).then((value) {
          showProgress(false);
          fullNameChanged(modalFullNameValue);
          modalFullNameChanged("");
          AppPreference.setString(FULL_NAME_KEY, fullNameValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void updatePhoneNumber(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({PHONE_NUMBER_KEY: modalPhoneNumberValue}).then(
                (value) {
          showProgress(false);
          phoneNumberChanged(modalPhoneNumberValue);
          modalPhoneNumberChanged("");
          AppPreference.setString(PHONE_NUMBER_KEY, phoneNumberValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void updateAge(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({AGE_KEY: modalAgeValue}).then((value) {
          showProgress(false);
          changeAge(modalAgeValue);
          modalAgeChanged("");
          AppPreference.setString(AGE_KEY, ageValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void updateAllergy(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({ALLERGIES_KEY: modalAllergyValue}).then((value) {
          showProgress(false);
          changeAllergy(modalAllergyValue);
          modalAllergyChanged("");
          AppPreference.setString(ALLERGIES_KEY, allergyValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void updateTrouble(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid)
            .updateData({TROUBLES_KEY: modalTroubleValue}).then((value) {
          showProgress(false);
          changeTrouble(modalTroubleValue);
          modalTroubleChanged("");
          AppPreference.setString(TROUBLES_KEY, troubleValue);
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
        showProgress(false);
      }
    });
  }

  void dispose() {
    _trouble?.close();
    _modalTrouble?.close();
    _allergy?.close();
    _modalAllergy?.close();
    _phoneNumber?.close();
    _modalPhoneNumber?.close();
    _age?.close();
    _modalAge?.close();
    _email?.close();
    _modalEmail?.close();
    _fullName?.close();
    _modalFullName?.close();
    _gender?.close();
    _dob?.close();
    _bloodGroup?.close();
    _showProgress?.close();
  }
}
