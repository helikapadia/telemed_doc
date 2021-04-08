import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:uuid/uuid.dart';

class ManualAnalysisBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _bpSys = BehaviorSubject<String>();
  final _bpDia = BehaviorSubject<String>();
  final _bsFast = BehaviorSubject<String>();
  final _bsBefore = BehaviorSubject<String>();
  final _dataId = BehaviorSubject<String>();
  final _analysisDate = BehaviorSubject<String>();
  DateFormat formatter = DateFormat('MMMM dd, yyyy');

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get bpSys => _bpSys.stream;
  Stream<String> get bpDia => _bpDia.stream;
  Stream<String> get bsFast => _bsFast.stream;
  Stream<String> get bsBefore => _bsBefore.stream;
  Stream<String> get dataId => _dataId.stream;
  Stream<String> get analysisDate => _analysisDate.stream;

  bool get progressBarValue => _showProgress.stream.value;
  String get bpSysValue => _bpSys.stream.value;
  String get bpDiaValue => _bpDia.stream.value;
  String get bsFastValue => _bsFast.stream.value;
  String get bsBeforeValue => _bsBefore.stream.value;
  String get dataIdValue => _dataId.stream.value;
  String get analysisDateValue => _analysisDate.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get changeBpSys => _bpSys.sink.add;
  Function(String) get changeBpDia => _bpDia.sink.add;
  Function(String) get changeBsFast => _bsFast.sink.add;
  Function(String) get changeBsBefore => _bsBefore.sink.add;
  Function(String) get changeDataId => _dataId.sink.add;
  Function(String) get changeAnalysisDate => _analysisDate.sink.add;

  Stream<bool> get submitCheck => Rx.combineLatest4(
      bpSys, bpDia, bsFast, bsBefore, (bpSys, bpDia, bsFast, bsBefore) => true);

  void submitManualData(BuildContext context) {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        final dataId = Uuid().v4();
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection(USER_COLLECTION + "/$userIdVal/manual_data_analysis")
            .doc(dataId);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            await documentReference.update({
              BLOOD_PRESSURE_SYS_KEY: bpSysValue,
              BLOOD_PRESSURE_DIA_KEY: bpDiaValue,
              BLOOD_SUGAR_FAST_KEY: bsFastValue,
              BLOOD_SUGAR_BEFORE_KEY: bsBeforeValue,
              ANALYSIS_DATE: analysisDateValue,
            }).then((value) async {
              showProgress(false);
              changeBpSys(bpSysValue);
              changeBpDia(bpDiaValue);
              changeBsFast(bsFastValue);
              changeBsBefore(bsBeforeValue);
              await AppPreference.setString(BLOOD_PRESSURE_SYS_KEY, bpSysValue);
              await AppPreference.setString(BLOOD_PRESSURE_DIA_KEY, bpDiaValue);
              await AppPreference.setString(BLOOD_SUGAR_FAST_KEY, bsFastValue);
              await AppPreference.setString(
                  BLOOD_SUGAR_BEFORE_KEY, bsBeforeValue);
              await AppPreference.setString(ANALYSIS_DATE, analysisDateValue);
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          } else {
            await documentReference.set({
              BLOOD_PRESSURE_SYS_KEY: bpSysValue,
              BLOOD_PRESSURE_DIA_KEY: bpDiaValue,
              BLOOD_SUGAR_FAST_KEY: bsFastValue,
              BLOOD_SUGAR_BEFORE_KEY: bsBeforeValue,
              ANALYSIS_DATE: analysisDateValue,
            }).then((value) async {
              showProgress(false);
              changeBpSys(bpSysValue);
              changeBpDia(bpDiaValue);
              changeBsFast(bsFastValue);
              changeBsBefore(bsBeforeValue);
              await AppPreference.setString(BLOOD_PRESSURE_SYS_KEY, bpSysValue);
              await AppPreference.setString(BLOOD_PRESSURE_DIA_KEY, bpDiaValue);
              await AppPreference.setString(BLOOD_SUGAR_FAST_KEY, bsFastValue);
              await AppPreference.setString(
                  BLOOD_SUGAR_BEFORE_KEY, bsBeforeValue);
              await AppPreference.setString(ANALYSIS_DATE, analysisDateValue);
              showDialogAndNavigate(
                  DATA_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.message, context);
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
    _bpDia?.close();
    _bpSys?.close();
    _showProgress?.close();
    _bsFast?.close();
    _bsBefore?.close();
  }
}
