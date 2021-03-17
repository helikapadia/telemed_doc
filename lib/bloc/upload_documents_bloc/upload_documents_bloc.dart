import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  //final _fileUrl = BehaviorSubject<String>();
  final _fileUrl = BehaviorSubject<List<ReportPDFUploadModel>>();
  final _reportId = BehaviorSubject<String>();
  final _reportDate = BehaviorSubject<String>();

  List<ReportPDFUploadModel> selectedFiles = [];

  Stream<bool> get Progress => _showProgress.stream;
  Stream<bool> get isKeyboardOpen => _isKeyboardOpen.stream;
  Stream<String> get reportName => _reportName.stream;
  Stream<String> get reportDescription => _reportDescription.stream;
  //Stream<String> get fileUrl => _fileUrl.stream;
  Stream<List<ReportPDFUploadModel>> get fileUrl => _fileUrl.stream;
  Stream<String> get reportId => _reportId.stream;
  Stream<String> get reportDate => _reportDate.stream;

  DateFormat formatter = DateFormat('MMMM dd, yyyy');

  bool get showProgressValue => _showProgress.stream.value;
  bool get isKeyboardOpenValue => _isKeyboardOpen.stream.value;
  String get reportNameValue => _reportName.stream.value;
  String get reportDescriptionValue => _reportDescription.stream.value;
  //String get fileUrlValue => _fileUrl.stream.value;
  List<ReportPDFUploadModel> get fileUrlValue => _fileUrl.stream.value;
  String get reportIdValue => _reportId.stream.value;
  String get reportDateValue => _reportDate.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(bool) get isKeyboardOpenChanged => _isKeyboardOpen.sink.add;
  Function(String) get reportNameChanged => _reportName.sink.add;
  Function(String) get reportDescriptionChanged => _reportDescription.sink.add;
  //Function(String) get fileUrlChanged => _fileUrl.sink.add;
  Function(List<ReportPDFUploadModel>) get fileUrlChanged => _fileUrl.sink.add;
  Function(String) get reportIdChanged => _reportId.sink.add;
  Function(String) get reportDateChanged => _reportDate.sink.add;

  void getReportId() {
    reportIdChanged(DateTime.now().toUtc().millisecondsSinceEpoch.toString());
  }

  Stream<bool> get submitReportDetail =>
      Rx.combineLatest2(reportName, reportDescription, (rn, rd) => true);
  // Stream<bool> get enableSubmitCheck =>
  //     reportName.map((s) => s.isNotEmpty && selectedFiles.isNotEmpty);
  File file;

  Future selectPdf(BuildContext context) async {
    FilePickerResult filePathOfPdf = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf']).catchError((errors) {
      showMessageDialog(PDF_ERROR, context);
    });
    if (filePathOfPdf.paths.length > 0) {
      selectedFiles.add(ReportPDFUploadModel(
        filePath: filePathOfPdf.paths[0],
        epochTime: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
      ));
      fileUrlChanged(selectedFiles);
      file = File(selectedFiles.first.filePath);
    }
    // if (filePathOfPdf != null) {
    //   File file = File(filePathOfPdf.files.single.path);
    //   fileUrlChanged(fileUrlValue);
    //   return file;
    // }
    else {
      showProgress(false);
      showMessageDialog(PDF_ERROR, context);
    }
  }

  void deleteAddedReportPDF(ReportPDFUploadModel reportPDFUploadModel) {
    selectedFiles.remove(reportPDFUploadModel);
    fileUrlChanged(fileUrlValue);
  }

  void uploadFile(BuildContext context) {
    try {
      AppHelper.checkInternetConnection().then((isAvailable) async {
        if (isAvailable) {
          if (file != null) {
            var userIdVal = FirebaseAuth.instance.currentUser.uid;
            final reportId = Uuid().v4();
            //StorageReference _storageReference = await FirebaseStorage.instance.ref().child("$REPORT_PDF_URL/${path.basename(fileChosenValue.path)}");final StorageUploadTask
            Reference _storageReference = FirebaseStorage.instance.ref().child(
                "REPORT_PDF/$userIdVal/BLOOD_REPORT/$reportId/BLOOD_REPORT.pdf");
            await _storageReference.putFile(File(selectedFiles.first.filePath));
            String link = await _storageReference.getDownloadURL();
            print("123     " + link);
            await FirebaseFirestore.instance
                .collection(USER_COLLECTION + "/$userIdVal/reports")
                .doc(reportId)
                .set({
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
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(e.message),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'))
                ],
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'))
                ],
              ));
    }
  }

  void dispose() {
    _showProgress?.close();
    _fileUrl?.close();
    _isKeyboardOpen?.close();
    _reportId?.close();
    _reportName?.close();
    _reportDescription?.close();
  }
}

//void uploadFile(BuildContext context) {
//     AppHelper.checkInternetConnection().then((isAvailable) async {
//       var userIdVal = FirebaseAuth.instance.currentUser.uid;
//       if (isAvailable) {
//         List<String> uploadUrls = [];
//         List<String> reportName = [];
//         // File file;
//         // = await selectPdf(context)
//         if (fileUrlValue?.isNotEmpty == true) {
//           await Future.wait(fileUrlValue.map((asset) async {
//           //   StorageReference _storageReference = FirebaseStorage().ref().child(
//           //       "REPORT_PDF/$userIdVal/BLOOD_REPORT/${reportId}_${asset.epochTime}/BLOOD_REPORT.pdf");
//           //   final StorageUploadTask _uploadTask =
//           //       _storageReference.putFile(File(asset.filePath));
//           //   final StreamSubscription<StorageTaskEvent> _streamSubscription =
//           //       _uploadTask.events.listen((event) {
//           //     double percent = event != null
//           //         ? event.snapshot.bytesTransferred /
//           //             event.snapshot.totalByteCount
//           //         : 0;
//           //   });
//           //   reportName.add(path.basename(asset.filePath));
//           //   uploadUrls
//           //       .add(await (await _uploadTask.onComplete).ref.getDownloadURL());
//           //
//           //   await _streamSubscription.cancel();
//           // }));
//           // String userId = userIdVal.uid;
//           // String epochTime =
//           //     DateTime.now().toUtc().millisecondsSinceEpoch.toString();
//           StorageReference _storageReference = await FirebaseStorage.instance.ref().child("$REPORT_PDF_URL/${path.basename(fileChosenValue.path)}");final StorageUploadTask
//           StorageReference _storageReference = FirebaseStorage.instance
//               .ref()
//               .child(
//                   "REPORT_PDF/$userIdVal/BLOOD_REPORT/$reportId/BLOOD_REPORT.pdf");
//           await _storageReference.putFile(file);
//           StorageUploadTask uploadTask = _storageReference.putFile(_path);
//           String link =
//               await (await uploadTask.onComplete).ref.getDownloadURL();
//           //_storageReference.getDownloadURL();
//           print("123     " + link);
//           DocumentReference documentReference = await Firestore.instance
//               .collection(USER_COLLECTION)
//               .document(userId)
//               .collection("/$userIdVal/reports")
//               .document(reportIdValue);
//
//           await documentReference.setData({
//             "blood_report_id": reportId,
//             REPORT_PDF_URL: uploadUrls ?? [],
//             TIME_STAMP_KEY: epochTime,
//             REPORT_DATE: reportDateValue,
//             REPORT_NAME: reportNameValue,
//             REPORT_DESCRIPTION: reportDescriptionValue,
//           }).then((isCompleted) {
//             showProgress(false);
//             // Navigator.pop(context);
//             showDialogAndNavigate(
//                 REPORT_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
//           }).catchError((error) {
//             showProgress(false);
//             showMessageDialog(error.message, context);
//           });
//           // AppPreference.setString("blood_report_id", reportId);
//           // AppPreference.setString("blood_report_link", link);
//           // AppPreference.setString(REPORT_NAME, reportNameValue);
//           // AppPreference.setString(REPORT_DESCRIPTION, reportDescriptionValue);
//         }
//       } else {
//         showProgress(false);
//         showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
//       }
//     });
//   }
