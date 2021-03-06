import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class UserProfileDetailBloc with UserProfileDetailValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _fullName = BehaviorSubject<String>();
  final _modalFullName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _modalEmail = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  // final _modalPhoneNumber = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _bloodGroup = BehaviorSubject<String>();
  final _allergy = BehaviorSubject<String>();
  final _trouble = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get fullName => _fullName.stream.transform(fullNameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phoneNumber => _phoneNumber.stream;
  Stream<String> get modalFullName =>
      _modalFullName.stream.transform(fullNameValidator);
  Stream<String> get modalEmail => _modalEmail.stream.transform(emailValidator);
  // Stream<String> get modalPhoneNumber =>
  //     _modalPhoneNumber.stream.transform(phoneNumberValidators);
  Stream<String> get gender => _gender.stream.transform(genderValidator);
  Stream<String> get age => _age.stream;
  Stream<String> get dob => _dob.stream;
  Stream<String> get bloodGroup => _bloodGroup.stream;
  Stream<String> get allergy => _allergy.stream;
  Stream<String> get trouble => _trouble.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get fullNameValue => _fullName.stream.value;
  String get emailValue => _email.stream.value;
  String get phoneNumberValue => _phoneNumber.stream.value;
  String get modalFullNameValue => _modalFullName.stream.value;
  String get modalEmailValue => _modalEmail.stream.value;
  // String get modalPhoneNumberValue => _modalPhoneNumber.stream.value;
  String get genderValue => _gender.stream.value;
  String get ageValue => _age.stream.value;
  String get dobValue => _dob.stream.value;
  String get bloodGroupValue => _bloodGroup.stream.value;
  String get allergyValue => _allergy.stream.value;
  String get troubleValue => _trouble.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get fullNameChanged => _fullName.sink.add;
  Function(String) get emailChanged => _email.sink.add;
  Function(String) get phoneNumberChanged => _phoneNumber.sink.add;
  Function(String) get modalFullNameChanged => _modalFullName.sink.add;
  Function(String) get modalEmailChanged => _modalEmail.sink.add;
  // Function(String) get modalPhoneNumberChanged => _modalPhoneNumber.sink.add;
  Function(String) get genderChanged => _gender.sink.add;
  Function(String) get changeAge => _age.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeBloodGroup => _bloodGroup.sink.add;
  Function(String) get changeAllergy => _allergy.sink.add;
  Function(String) get changeTrouble => _trouble.sink.add;

  Stream<bool> get submitUserDetail => Rx.combineLatest6(age, phoneNumber, dob,
      bloodGroup, allergy, trouble, (a, ph, d, bg, all, tr) => true);

  void addDoctorDetails(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        DocumentReference documentReference = Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            await documentReference.updateData({
              // FULL_NAME_KEY: fullNameValue,
              AGE_KEY: ageValue,
              // GENDER_KEY: genderValue,
              // EMAIL_KEY: emailValue,
              PHONE_NUMBER_KEY: phoneNumberValue,
              DOB_KEY: dobValue,
              BLOOD_GROUP_KEY: bloodGroupValue,
              ALLERGIES_KEY: allergyValue,
              TROUBLES_KEY: troubleValue,
            }).then((value) async {
              showProgress(false);
              // fullNameChanged(fullNameValue);
              changeAge(ageValue);
              // genderChanged(genderValue);
              // emailChanged(emailValue);
              changeDob(dobValue);
              phoneNumberChanged(phoneNumberValue);
              changeBloodGroup(bloodGroupValue);
              changeAllergy(allergyValue);
              changeTrouble(troubleValue);
              await AppPreference.setString(FULL_NAME_KEY, fullNameValue);
              await AppPreference.setString(AGE_KEY, ageValue);
              await AppPreference.setString(GENDER_KEY, genderValue);
              await AppPreference.setString(EMAIL_KEY, emailValue);
              await AppPreference.setString(DOB_KEY, dobValue);
              await AppPreference.setString(BLOOD_GROUP_KEY, bloodGroupValue);
              await AppPreference.setString(PHONE_NUMBER_KEY, phoneNumberValue);
              await AppPreference.setString(ALLERGIES_KEY, allergyValue);
              await AppPreference.setString(TROUBLES_KEY, troubleValue);
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, DOCTOR_DETAIL_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          } else {
            await documentReference.setData({
              FULL_NAME_KEY: fullNameValue,
              AGE_KEY: ageValue,
              GENDER_KEY: genderValue,
              EMAIL_KEY: emailValue,
              PHONE_NUMBER_KEY: phoneNumberValue,
              DOB_KEY: dobValue,
              BLOOD_GROUP_KEY: bloodGroupValue,
              ALLERGIES_KEY: allergyValue,
              TROUBLES_KEY: troubleValue,
            }).then((value) async {
              showProgress(false);
              fullNameChanged(fullNameValue);
              changeAge(ageValue);
              genderChanged(genderValue);
              emailChanged(emailValue);
              changeDob(dobValue);
              phoneNumberChanged(phoneNumberValue);
              changeBloodGroup(bloodGroupValue);
              changeAllergy(allergyValue);
              changeTrouble(troubleValue);
              await AppPreference.setString(FULL_NAME_KEY, fullNameValue);
              await AppPreference.setString(AGE_KEY, ageValue);
              await AppPreference.setString(GENDER_KEY, genderValue);
              await AppPreference.setString(EMAIL_KEY, emailValue);
              await AppPreference.setString(DOB_KEY, dobValue);
              await AppPreference.setString(BLOOD_GROUP_KEY, bloodGroupValue);
              await AppPreference.setString(PHONE_NUMBER_KEY, phoneNumberValue);
              await AppPreference.setString(ALLERGIES_KEY, allergyValue);
              await AppPreference.setString(TROUBLES_KEY, troubleValue);
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
    _age?.close();
    _gender?.close();
    _phoneNumber?.close();
    _email?.close();
    _fullName?.close();
    _modalEmail?.close();
    _modalFullName?.close();
  }
}
