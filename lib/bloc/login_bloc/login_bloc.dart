import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/login_bloc/login_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginBloc with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>.seeded(false);

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<bool> get progress => _showProgress.stream;

  String get emailValue => _emailController.stream.value;
  String get passwordValue => _passwordController.stream.value;
  bool get progressBarValue => _showProgress.stream.value;

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(bool) get showProgress => _showProgress.sink.add;

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(email, password, (e, p) => true);

  void loginUser(BuildContext context) {
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) {
      if (isAvailable) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailValue, password: passwordValue)
            .then((authResult) async {
          if (authResult.user.emailVerified) {
            await AppPreference.setString(USER_ID_KEY, authResult.user.uid);
            await FirebaseFirestore.instance
                .collection(USER_COLLECTION)
                .doc(authResult.user.uid)
                .update({
              EMAIL_KEY: emailValue,
              USER_ID_KEY: authResult.user.uid,
              IS_ACTIVE: true,
              IS_EMAIL_VERIFIED: true
            });
            await FirebaseFirestore.instance
                .collection(USER_COLLECTION)
                .doc(authResult.user.uid)
                .get()
                .then((DocumentSnapshot documentSnapshot) async {
              await AppPreference.setString(
                  USER_EMAIL, documentSnapshot.data()['email']);
              await AppPreference.setString(
                  USER_GENDER, documentSnapshot.data()['gender']);
              await AppPreference.setString(
                  USER_FULL_NAME, documentSnapshot.data()['full_name']);

              if (documentSnapshot.data().containsKey(CITY_KEY)) {
                await AppPreference.setString(
                    CITY_KEY, documentSnapshot.data()['city']);
              }

              if (documentSnapshot.data().containsKey(EMERGENCY_EMAIL_KEY)) {
                await AppPreference.setString(EMERGENCY_EMAIL_KEY,
                    documentSnapshot.data()['emergency_email']);
              }

              if (documentSnapshot
                  .data()
                  .containsKey(EMERGENCY_PHONE_NUMBER_KEY)) {
                await AppPreference.setString(EMERGENCY_PHONE_NUMBER_KEY,
                    documentSnapshot.data()['emergency_phone_number']);
              }

              if (documentSnapshot.data().containsKey(AGE_KEY)) {
                await AppPreference.setString(
                    AGE_KEY, documentSnapshot.data()['age']);
              }

              if (documentSnapshot.data().containsKey(DOB_KEY)) {
                await AppPreference.setString(
                    DOB_KEY, documentSnapshot.data()['dob']);
              }

              if (documentSnapshot.data().containsKey(ALLERGIES_KEY)) {
                await AppPreference.setString(
                    ALLERGIES_KEY, documentSnapshot.data()['allergy']);
              }

              if (documentSnapshot.data().containsKey(TROUBLES_KEY)) {
                await AppPreference.setString(
                    TROUBLES_KEY, documentSnapshot.data()['trouble']);
              }

              if (documentSnapshot.data().containsKey(PHONE_NUMBER_KEY)) {
                await AppPreference.setString(
                    PHONE_NUMBER_KEY, documentSnapshot.data()['phone_number']);
              }

              if (documentSnapshot.data().containsKey(BLOOD_GROUP_KEY)) {
                await AppPreference.setString(
                    BLOOD_GROUP_KEY, documentSnapshot.data()['blood_group']);
              }

              if (documentSnapshot.data().containsKey(authStatusKey)) {
                await AppPreference.setString(
                    authStatusKey, documentSnapshot.data()['auth_status']);
              }
            });
            showProgress(false);
            showDialogAndNavigate(LOGIN_SUCCESSFUL, context, ADD_CITY);
          }
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showProgress(false);
        showMessageDialog(EMAIL_NOT_VERIFIED, context);
      }
    }).catchError((errors) {
      showProgress(false);
      showMessageDialog(errors.message, context);
    });
  }

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
    _showProgress?.close();
  }
}
