import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _dailyMedicineName = BehaviorSubject<String>();
  final _dailyMedicineType = BehaviorSubject<String>();
  final _dailyMedicineNumber = BehaviorSubject<String>();
  final _dailyMedicineDosage = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get dailyMedicineName => _dailyMedicineName.stream;
  Stream<String> get dailyMedicineType => _dailyMedicineType.stream;
  Stream<String> get dailyMedicineNumber => _dailyMedicineNumber.stream;
  Stream<String> get dailyMedicineDosage => _dailyMedicineDosage.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get dailyMedicineNameValue => _dailyMedicineName.stream.value;
  String get dailyMedicineTypeValue => _dailyMedicineType.stream.value;
  String get dailyMedicineNumberValue => _dailyMedicineNumber.stream.value;
  String get dailyMedicineDosageValue => _dailyMedicineDosage.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get changeDailyMedicineName => _dailyMedicineName.sink.add;
  Function(String) get changeDailyMedicineType => _dailyMedicineType.sink.add;
  Function(String) get changeDailyMedicineNumber =>
      _dailyMedicineNumber.sink.add;
  Function(String) get changeDailyMedicineDosage =>
      _dailyMedicineDosage.sink.add;

  Stream<bool> get submitDailyMedicine => Rx.combineLatest4(
      dailyMedicineName,
      dailyMedicineNumber,
      dailyMedicineType,
      dailyMedicineDosage,
      (n, num, type, d) => true);

  void addDailyMedicine(BuildContext context) async {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        DocumentReference documentReference =
            Firestore.instance.collection(USER_COLLECTION).doc(userIdVal);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            await documentReference.update({
              DAILY_MEDICINE_NAME_KEY: dailyMedicineNameValue,
              DAILY_MEDICINE_TYPE_KEY: dailyMedicineTypeValue,
              DAILY_MEDICINE_NUMBER_KEY: dailyMedicineNumberValue,
              DAILY_MEDICINE_DOSAGE_KEY: dailyMedicineDosageValue,
            }).then((value) async {
              showProgress(false);
              changeDailyMedicineName(dailyMedicineNameValue);
              changeDailyMedicineNumber(dailyMedicineNumberValue);
              changeDailyMedicineType(dailyMedicineTypeValue);
              changeDailyMedicineDosage(dailyMedicineDosageValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_NAME_KEY, dailyMedicineNameValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_TYPE_KEY, dailyMedicineTypeValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_NUMBER_KEY, dailyMedicineNumberValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_DOSAGE_KEY, dailyMedicineDosageValue);
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          } else {
            await documentReference.set({
              DAILY_MEDICINE_NAME_KEY: dailyMedicineNameValue,
              DAILY_MEDICINE_TYPE_KEY: dailyMedicineTypeValue,
              DAILY_MEDICINE_NUMBER_KEY: dailyMedicineNumberValue,
              DAILY_MEDICINE_DOSAGE_KEY: dailyMedicineDosageValue,
            }).then((value) async {
              showProgress(false);
              changeDailyMedicineName(dailyMedicineNameValue);
              changeDailyMedicineNumber(dailyMedicineNumberValue);
              changeDailyMedicineType(dailyMedicineTypeValue);
              changeDailyMedicineDosage(dailyMedicineDosageValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_NAME_KEY, dailyMedicineNameValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_TYPE_KEY, dailyMedicineTypeValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_NUMBER_KEY, dailyMedicineNumberValue);
              await AppPreference.setString(
                  DAILY_MEDICINE_DOSAGE_KEY, dailyMedicineDosageValue);
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
    _dailyMedicineName?.close();
    _dailyMedicineDosage?.close();
    _showProgress?.close();
    _dailyMedicineType?.close();
    _dailyMedicineNumber?.close();
  }
}
