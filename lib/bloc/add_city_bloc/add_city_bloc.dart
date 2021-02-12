import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class AddCityBloc {
  final _city = BehaviorSubject<String>();
  final _modalCity = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _userId = BehaviorSubject<String>();

  static var auth;

  Stream<String> get addCity => _city.stream;
  Stream<String> get modalCity => _modalCity.stream;
  Stream<bool> get Progress => _showProgress.stream;
  Stream<String> get userId => _userId.stream;

  String get addCityValue => _city.stream.value;
  String get modalCityValue => _modalCity.stream.value;
  bool get progressBarValue => _showProgress.stream.value;
  String get userIdValue => _userId.stream.value;

  Function(String) get changeAddCity => _city.sink.add;
  Function(String) get changeModalCity => _modalCity.sink.add;
  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get userIdChanged => _userId.sink.add;

  Stream<bool> get submitcity => addCity.map((a) => true);

  void getData() {
    // AppPreference.getStringF(USER_ID_KEY).then((value) {
    //   userIdChanged(value);
    // }).catchError((error) {
    //   userIdChanged("");
    // });

    AppPreference.getStringF(CITY_KEY).then((value) {
      changeAddCity(value);
    }).catchError((error) {
      changeAddCity("");
    });
  }

  void submitAddCity(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection(USER_COLLECTION).doc(userIdVal);
          await documentReference.get().then((doc) async {
            if(doc.exists){
            await documentReference.update({CITY_KEY: addCityValue}).then((
                value) async {
              showProgress(false);
              changeAddCity(modalCityValue);
              changeModalCity("");
              await AppPreference.setString(CITY_KEY, addCityValue);
              showDialogAndNavigate(CITY_ADDED_SUCCESSFULLY, context, EMERGENCY_CONTACT_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          }else{
              await documentReference.set({CITY_KEY: modalCityValue}).then((value) async{
                showProgress(false);
                changeAddCity(modalCityValue);
                changeModalCity("");
                await AppPreference.setString(CITY_KEY, addCityValue);
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
    _city?.close();
    _modalCity?.close();
    _showProgress?.close();
    _userId?.close();
  }
}
//FirebaseFirestore.instance
//             .collection(USER_COLLECTION)
//             .doc(userIdValue)
//             .update({
//           CITY_KEY: addCityValue,
//         }).then((value) {
//           showProgress(false);
//           changeAddCity(modalCityValue);
//           changeModalCity("");
//           AppPreference.setString(CITY_KEY, addCityValue);
//           showDialogAndNavigate(
//               CITY_ADDED_SUCCESSFULLY, context, EMERGENCY_CONTACT_SCREEN);
//         }).catchError((error) {
//           showProgress(false);
//           showMessageDialog(error.message, context);
//         });