import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class FamilyMemberProfileBloc with ProfileValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _fullName = BehaviorSubject<String>();
  final _modalFullName = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _bloodGroup = BehaviorSubject<String>();
  final _allergy = BehaviorSubject<String>();
  final _modalAllergy = BehaviorSubject<String>();
  final _trouble = BehaviorSubject<String>();
  final _modalTrouble = BehaviorSubject<String>();
  final _familyHistory = BehaviorSubject<String>();
  final _modalFamilyHistory = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get fullName => _fullName.stream.transform(fullNameValidator);
  Stream<String> get modalFullName =>
      _modalFullName.stream.transform(fullNameValidator);
  Stream<String> get gender => _gender.stream.transform(genderValidator);
  Stream<String> get dob => _dob.stream;
  Stream<String> get bloodGroup => _bloodGroup.stream;
  Stream<String> get allergy => _allergy.stream;
  Stream<String> get modalAllergy => _modalAllergy.stream;
  Stream<String> get trouble => _trouble.stream;
  Stream<String> get modalTrouble => _modalTrouble.stream;
  Stream<String> get familyHistory => _familyHistory.stream;
  Stream<String> get modalFamilyHistory => _modalFamilyHistory.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get fullNameValue => _fullName.stream.value;
  String get modalFullNameValue => _modalFullName.stream.value;
  String get genderValue => _gender.stream.value;
  String get dobValue => _dob.stream.value;
  String get bloodGroupValue => _bloodGroup.stream.value;
  String get allergyValue => _allergy.stream.value;
  String get modalAllergyValue => _modalAllergy.stream.value;
  String get troubleValue => _trouble.stream.value;
  String get modalTroubleValue => _modalTrouble.stream.value;
  String get familyHistoryValue => _familyHistory.stream.value;
  String get modalFamilyHistoryValue => _modalFamilyHistory.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get fullNameChanged => _fullName.sink.add;
  Function(String) get modalFullNameChanged => _modalFullName.sink.add;
  Function(String) get genderChanged => _gender.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeBloodGroup => _bloodGroup.sink.add;
  Function(String) get changeAllergy => _allergy.sink.add;
  Function(String) get modalAllergyChanged => _modalAllergy.sink.add;
  Function(String) get changeTrouble => _trouble.sink.add;
  Function(String) get modalTroubleChanged => _modalTrouble.sink.add;
  Function(String) get changeFamilyHistory => _familyHistory.sink.add;
  Function(String) get modalFamilyHistoryChanged =>
      _modalFamilyHistory.sink.add;

  Stream<bool> get enableFullNameSubmitCheck => _fullName.map((event) => true);
  Stream<bool> get enableAllergySubmitCheck => _allergy.map((event) => true);
  Stream<bool> get enableTroubleSubmitCheck => _trouble.map((event) => true);

  void getData() {
    AppPreference.getStringF(FAM_FULL_NAME_KEY).then((value) {
      fullNameChanged(value);
    }).catchError((error) {
      fullNameChanged("");
    });

    AppPreference.getStringF(FAM_GENDER_KEY).then((value) {
      genderChanged(value);
    });

    AppPreference.getStringF(FAM_BLOOD_GROUP_KEY).then((value) {
      changeBloodGroup(value);
    });

    AppPreference.getStringF(FAM_DOB_KEY).then((value) {
      changeDob(value);
    });

    AppPreference.getStringF(FAM_ALLERGIES_KEY).then((value) {
      changeAllergy(value);
    }).catchError((error) {
      changeAllergy("");
    });

    AppPreference.getStringF(FAM_TROUBLES_KEY).then((value) {
      changeTrouble(value);
    }).catchError((error) {
      changeTrouble("");
    });

    AppPreference.getStringF(FAM_FAMILY_HISTORY_KEY).then((value) {
      changeFamilyHistory(value);
    }).catchError((error) {
      changeFamilyHistory("");
    });
  }

  void updateFullName(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal)
            .update({FAM_FULL_NAME_KEY: modalFullNameValue}).then((value) {
          showProgress(false);
          fullNameChanged(modalFullNameValue);
          modalFullNameChanged("");
          AppPreference.setString(FAM_FULL_NAME_KEY, fullNameValue);
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
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal)
            .update({ALLERGIES_KEY: modalAllergyValue}).then((value) {
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
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal)
            .update({TROUBLES_KEY: modalTroubleValue}).then((value) {
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
    _fullName?.close();
    _modalFullName?.close();
    _gender?.close();
    _dob?.close();
    _bloodGroup?.close();
    _showProgress?.close();
  }
}
