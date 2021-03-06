import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:uuid/uuid.dart';

class UploadDocumentsBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _isKeyboardOpen = BehaviorSubject<bool>.seeded(false);
  final _reportName = BehaviorSubject<String>();
  final _reportDescription = BehaviorSubject<String>();
  final _fileChosen = BehaviorSubject<File>();
  final _fileUrl = BehaviorSubject<String>();
  final _reportId = BehaviorSubject<String>();

  Stream<bool> get Progress => _showProgress.stream;
  Stream<bool> get isKeyboardOpen => _isKeyboardOpen.stream;
  Stream<String> get reportName => _reportName.stream;
  Stream<String> get reportDescription => _reportDescription.stream;
  Stream<File> get fileChosen => _fileChosen.stream;
  Stream<String> get fileUrl => _fileUrl.stream;
  Stream<String> get reportId => _reportId.stream;

  DateFormat formatter = DateFormat('MMMM dd, yyyy');

  bool get showProgressValue => _showProgress.stream.value;
  bool get isKeyboardOpenValue => _isKeyboardOpen.stream.value;
  String get reportNameValue => _reportName.stream.value;
  String get reportDescriptionValue => _reportDescription.stream.value;
  File get fileChosenValue => _fileChosen.stream.value;
  String get fileUrlValue => _fileUrl.stream.value;
  String get reportIdValue => _reportId.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(bool) get isKeyboardOpenChanged => _isKeyboardOpen.sink.add;
  Function(String) get reportNameChanged => _reportName.sink.add;
  Function(String) get reportDescriptionChanged => _reportDescription.sink.add;
  Function(File) get fileChanged => _fileChosen.sink.add;
  Function(String) get fileUrlChanged => _fileUrl.sink.add;
  Function(String) get reportIdChanged => _reportId.sink.add;

  void getReportId() {
    reportIdChanged(DateTime.now().toUtc().millisecondsSinceEpoch.toString());
  }

  Stream<bool> get submitReportDetail =>
      Rx.combineLatest2(reportName, reportDescription, (rn, rd) => true);

  Future selectPdf(BuildContext context) async {
    FilePickerResult pdf = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf']).catchError((errors) {
      showMessageDialog(PDF_ERROR, context);
    });
    if (pdf != null) {
      File file = File(pdf.files.single.path);
      return file;
    } else {
      showProgress(false);
      showMessageDialog(PDF_ERROR, context);
    }
  }

  void uploadFile(BuildContext context) {
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        File file = await selectPdf(context);
        if (file != null) {
          FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
          final reportId = Uuid().v4();
          //StorageReference _storageReference = await FirebaseStorage.instance.ref().child("$REPORT_PDF_URL/${path.basename(fileChosenValue.path)}");final StorageUploadTask
          StorageReference _storageReference = FirebaseStorage.instance
              .ref()
              .child(
                  "REPORT_PDF/$userIdVal/BLOOD_REPORT/$reportId/BLOOD_REPORT.pdf");
          await _storageReference.putFile(file);
          String link = await _storageReference.getDownloadURL();
          print("123     " + link);
          await Firestore.instance
              .collection(USER_COLLECTION + "/$userIdVal/reports")
              .document(reportId)
              .setData({
            "blood_report_id": reportId,
            "blood_report_link": link,
            REPORT_NAME: reportNameValue,
            REPORT_DESCRIPTION: reportDescriptionValue,
          });
          showProgress(false);
          // AppPreference.setString("blood_report_id", reportId);
          // AppPreference.setString("blood_report_link", link);
          // AppPreference.setString(REPORT_NAME, reportNameValue);
          // AppPreference.setString(REPORT_DESCRIPTION, reportDescriptionValue);
          showDialogAndNavigate(
              REPORT_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
        }
      } else {
        showProgress(false);
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
      }
    });
  }

  void dispose() {
    _showProgress?.close();
    _fileUrl?.close();
    _isKeyboardOpen?.close();
    _fileChosen?.close();
    _reportId?.close();
    _reportName?.close();
    _reportDescription?.close();
  }
}
