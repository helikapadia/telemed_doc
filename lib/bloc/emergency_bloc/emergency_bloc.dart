import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/emergency_bloc/emergency_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyBloc with EmergencyValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _modalPhoneNumber = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phoneNumber => _phoneNumber.stream;
  Stream<String> get modalPhoneNumber =>
      _modalPhoneNumber.stream.transform(phoneNumberValidators);

  bool get progressBarValue => _showProgress.stream.value;
  String get emailValue => _email.stream.value;
  String get phoneNumberValue => _phoneNumber.stream.value;
  String get modalPhoneNumberValue => _modalPhoneNumber.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get emailChanged => _email.sink.add;
  Function(String) get phoneNumberChanged => _phoneNumber.sink.add;
  Function(String) get modalPhoneNumberChanged => _modalPhoneNumber.sink.add;

  Future<void> openMail(String email, BuildContext context) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      showMessageDialog(EMAIL_FAILURE, context);
    }
  }

  Future<void> openPhoneDialer(String phoneNumber, BuildContext context) async {
    await canLaunch("tel:$phoneNumber").then((value) async {
      value
          ? await launch("tel:$phoneNumber")
          : showMessageDialog(PHONE_NUMBER_FAILURE, context);
    }).catchError((errors) {
      showMessageDialog(errors.message, context);
    });
  }

  Stream<bool> get submitemergency =>
      Rx.combineLatest2(email, phoneNumber, (e, p) => true);

  void submitEmergencyDetails(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            await documentReference.update({
              EMERGENCY_EMAIL_KEY: emailValue,
              EMERGENCY_PHONE_NUMBER_KEY: phoneNumberValue
            }).then((value) async {
              showProgress(false);
              emailChanged(emailValue);
              phoneNumberChanged(phoneNumberValue);
              await AppPreference.setString(EMERGENCY_EMAIL_KEY, emailValue);
              await AppPreference.setString(
                  EMERGENCY_PHONE_NUMBER_KEY, phoneNumberValue);
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, USER_DETAIL_PROFILE);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          } else {
            await documentReference.set({
              EMERGENCY_EMAIL_KEY: emailValue,
              EMERGENCY_PHONE_NUMBER_KEY: phoneNumberValue
            }).then((value) async {
              showProgress(false);
              emailChanged(emailValue);
              phoneNumberChanged(phoneNumberValue);
              emailChanged("");
              phoneNumberChanged("");
              await AppPreference.setString(EMERGENCY_EMAIL_KEY, emailValue);
              await AppPreference.setString(
                  EMERGENCY_PHONE_NUMBER_KEY, phoneNumberValue);
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
    _email?.close();
    _showProgress?.close();
    _modalPhoneNumber?.close();
    _phoneNumber?.close();
  }
}
