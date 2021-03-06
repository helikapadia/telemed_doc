import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/registration_bloc/registration_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class RegistrationBloc with RegistrationValidators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _fullNameController = BehaviorSubject<String>();
  final _genderController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>.seeded(false);

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get fullName =>
      _fullNameController.stream.transform(fullNameValidator);
  Stream<String> get gender =>
      _genderController.stream.transform(genderValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPasswordController.stream.transform(passwordValidator);
  Stream<bool> get progress => _showProgress.stream;

  String get emailValue => _emailController.stream.value;
  String get fullNameValue => _fullNameController.stream.value;
  String get genderValue => _genderController.stream.value;
  String get passwordValue => _passwordController.stream.value;
  String get confirmPasswordValue => _confirmPasswordController.stream.value;
  bool get progressBarValue => _showProgress.stream.value;

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get fullNameChanged => _fullNameController.sink.add;
  Function(String) get genderChanged => _genderController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get confirmPasswordChanged =>
      _confirmPasswordController.sink.add;
  Function(bool) get showProgress => _showProgress.sink.add;

  Stream<bool> get submitCheck => Rx.combineLatest5(email, fullName, gender,
      password, confirmPassword, (e, f, g, p, cp) => true);

  void registerUser(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) {
      print("123");
      if (isAvailable) {
        print("1");
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailValue,
          password: passwordValue,
        )
            .then((authResult) async {
          print("234");
          await authResult.user.sendEmailVerification();
          await AppPreference.setString(USER_EMAIL, emailValue);
          await AppPreference.setString(USER_FULL_NAME, fullNameValue);
          await AppPreference.setString(USER_GENDER, genderValue);

          await Firestore.instance
              .collection(USER_COLLECTION)
              .document(authResult.user.uid)
              .setData({
            EMAIL_KEY: emailValue,
            GENDER_KEY: genderValue,
            FULL_NAME_KEY: fullNameValue,
            USER_ID_KEY: authResult.user.uid,
            IS_ACTIVE: false,
            IS_EMAIL_VERIFIED: false,
          }).then((isCompleted) {
            showProgress(false);
            showDialogAndNavigate(
                PLEASE_CHECK_YOUR_MAIL_FOR_VERIFICATION, context, LOGIN_ROUTE);
          }).catchError((error) {
            showProgress(false);
            showMessageDialog(error.message, context);
          });
        }).catchError((errors) {
          showProgress(false);
          showMessageDialog(errors.message, context);
        });
      } else {
        showProgress(false);
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
      }
    });
  }

  void dispose() {
    _emailController.close();
    _genderController.close();
    _fullNameController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _showProgress.close();
  }
}
