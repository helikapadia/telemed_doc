import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class AddFamilyBloc with AddFamilyValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _fullName = BehaviorSubject<String>();
  final _modalFullName = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _bloodGroup = BehaviorSubject<String>();
  final _allergy = BehaviorSubject<String>();
  final _trouble = BehaviorSubject<String>();
  final _familyHistory = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get fullName => _fullName.stream.transform(fullNameValidator);
  Stream<String> get modalFullName =>
      _modalFullName.stream.transform(fullNameValidator);
  Stream<String> get gender => _gender.stream.transform(genderValidator);
  Stream<String> get dob => _dob.stream;
  Stream<String> get bloodGroup => _bloodGroup.stream;
  Stream<String> get allergy => _allergy.stream;
  Stream<String> get trouble => _trouble.stream;
  Stream<String> get familyHistory => _familyHistory.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get fullNameValue => _fullName.stream.value;
  String get modalFullNameValue => _modalFullName.stream.value;
  String get genderValue => _gender.stream.value;
  String get dobValue => _dob.stream.value;
  String get bloodGroupValue => _bloodGroup.stream.value;
  String get allergyValue => _allergy.stream.value;
  String get troubleValue => _trouble.stream.value;
  String get familyHistoryValue => _familyHistory.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get fullNameChanged => _fullName.sink.add;
  Function(String) get modalFullNameChanged => _modalFullName.sink.add;
  Function(String) get genderChanged => _gender.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeBloodGroup => _bloodGroup.sink.add;
  Function(String) get changeAllergy => _allergy.sink.add;
  Function(String) get changeTrouble => _trouble.sink.add;
  Function(String) get changeFamilyHistory => _familyHistory.sink.add;

  Stream<bool> get submitCheck => Rx.combineLatest7(
      fullName,
      gender,
      dob,
      bloodGroup,
      allergy,
      trouble,
      familyHistory,
      (fn, g, d, bg, all, tr, fh) => true);
  void addFamilyDetails(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection(FAMILY_COLLECTION)
            .doc(userIdVal);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            debugPrint("hel");
            await documentReference.update({
              FAM_FULL_NAME_KEY: fullNameValue,
              FAM_GENDER_KEY: genderValue,
              FAM_DOB_KEY: dobValue,
              FAM_BLOOD_GROUP_KEY: bloodGroupValue,
              FAM_ALLERGIES_KEY: allergyValue,
              FAM_TROUBLES_KEY: troubleValue,
              FAM_FAMILY_HISTORY_KEY: familyHistoryValue,
            }).then((value) async {
              showProgress(false);
              fullNameChanged(fullNameValue);
              genderChanged(genderValue);
              changeDob(dobValue);
              changeBloodGroup(bloodGroupValue);
              changeAllergy(allergyValue);
              changeTrouble(troubleValue);
              changeFamilyHistory(familyHistoryValue);
              await AppPreference.setString(FAM_FULL_NAME_KEY, fullNameValue);
              await AppPreference.setString(FAM_GENDER_KEY, genderValue);
              await AppPreference.setString(FAM_DOB_KEY, dobValue);
              await AppPreference.setString(
                  FAM_BLOOD_GROUP_KEY, bloodGroupValue);
              await AppPreference.setString(FAM_ALLERGIES_KEY, allergyValue);
              await AppPreference.setString(FAM_TROUBLES_KEY, troubleValue);
              await AppPreference.setString(
                  FAM_FAMILY_HISTORY_KEY, familyHistoryValue);
              debugPrint("hel");
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, PROFILE_TAB_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.message, context);
            });
          } else {
            await documentReference.set({
              FAM_FULL_NAME_KEY: fullNameValue,
              FAM_GENDER_KEY: genderValue,
              FAM_DOB_KEY: dobValue,
              FAM_BLOOD_GROUP_KEY: bloodGroupValue,
              FAM_ALLERGIES_KEY: allergyValue,
              FAM_TROUBLES_KEY: troubleValue,
              FAM_FAMILY_HISTORY_KEY: familyHistoryValue,
            }).then((value) async {
              showProgress(false);
              fullNameChanged(fullNameValue);
              genderChanged(genderValue);
              changeDob(dobValue);
              changeBloodGroup(bloodGroupValue);
              changeAllergy(allergyValue);
              changeTrouble(troubleValue);
              changeFamilyHistory(familyHistoryValue);
              await AppPreference.setString(FAM_FULL_NAME_KEY, fullNameValue);
              await AppPreference.setString(FAM_GENDER_KEY, genderValue);
              await AppPreference.setString(FAM_DOB_KEY, dobValue);
              await AppPreference.setString(
                  FAM_BLOOD_GROUP_KEY, bloodGroupValue);
              await AppPreference.setString(FAM_ALLERGIES_KEY, allergyValue);
              await AppPreference.setString(FAM_TROUBLES_KEY, troubleValue);
              await AppPreference.setString(
                  FAM_FAMILY_HISTORY_KEY, familyHistoryValue);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          }
        });
      } else {
        showProgress(false);
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
      }
    });
  }

  void dispose() {
    _showProgress?.close();
    _trouble?.close();
    _allergy?.close();
    _bloodGroup?.close();
    _dob?.close();
    _gender?.close();
    _fullName?.close();
    _modalFullName?.close();
    _familyHistory?.close();
  }
}
