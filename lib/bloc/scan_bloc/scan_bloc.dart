import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:uuid/uuid.dart';

class ScanBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _isKeyboardOpen = BehaviorSubject<bool>.seeded(false);
  final _reportName = BehaviorSubject<String>();
  final _reportDescription = BehaviorSubject<String>();
  final _imageSelectedFromCamera = BehaviorSubject<bool>.seeded(false);
  final _reportId = BehaviorSubject<String>();
  final _reportDate = BehaviorSubject<String>();
  final _reportFolder = BehaviorSubject<String>();

  Stream<bool> get Progress => _showProgress.stream;
  Stream<bool> get isKeyboardOpen => _isKeyboardOpen.stream;
  Stream<String> get reportName => _reportName.stream;
  Stream<String> get reportDescription => _reportDescription.stream;
  Stream<bool> get imageSelectedFromCamera => _imageSelectedFromCamera.stream;
  Stream<String> get reportId => _reportId.stream;
  Stream<String> get reportDate => _reportDate.stream;
  Stream<String> get reportFolder => _reportFolder.stream;

  DateFormat formatter = DateFormat('MMMM dd, yyyy');

  bool get showProgressValue => _showProgress.stream.value;
  bool get isKeyboardOpenValue => _isKeyboardOpen.stream.value;
  String get reportNameValue => _reportName.stream.value;
  String get reportDescriptionValue => _reportDescription.stream.value;
  bool get imageSelectedFromCameraValue =>
      _imageSelectedFromCamera.stream.value;
  String get reportIdValue => _reportId.stream.value;
  String get reportDateValue => _reportDate.stream.value;
  String get reportFolderValue => _reportFolder.stream.value;

  Function(bool) get showProgressChanged => _showProgress.sink.add;
  Function(bool) get isKeyboardOpenChanged => _isKeyboardOpen.sink.add;
  Function(String) get reportNameChanged => _reportName.sink.add;
  Function(String) get reportDescriptionChanged => _reportDescription.sink.add;
  Function(bool) get imageSelectedFromCameraChanged =>
      _imageSelectedFromCamera.sink.add;
  Function(String) get reportIdChanged => _reportId.sink.add;
  Function(String) get reportDateChanged => _reportDate.sink.add;
  Function(String) get reportFolderChanged => _reportFolder.sink.add;

  List<PickedImageModel> photoSelected = [
    new PickedImageModel(
        isFromLib: null, img: null, identifier: null, epochTimeStamp: null)
  ];

  Stream<bool> get submitCheck => Rx.combineLatest3(
      reportName,
      reportDescription,
      reportFolder,
      (
        rn,
        rd,
        rf,
      ) =>
          true);

  var image;

  Future takePhotoFromCamera(BuildContext context) async {
    var picker = ImagePicker();
    PickedFile img = await picker
        .getImage(source: ImageSource.camera, imageQuality: 70)
        .catchError((error) {
      showMessageDialog(error.message, context);
    });
    showProgressChanged(true);
    if (img != null) {
      photoSelected.add(PickedImageModel(
          isFromLib: false,
          img: img.path,
          identifier: basename(img.path),
          epochTimeStamp:
              DateTime.now().toUtc().millisecondsSinceEpoch.toString()));
      showProgressChanged(false);
      imageSelectedFromCameraChanged(true);
      image = img.path;
      debugPrint("1235567788" + img.path);
      return img.path;
    } else {
      showProgressChanged(false);
    }
  }

  var index;
  var pdf1;
  var file;
  final pdf = pw.Document();
  var userIdVal = FirebaseAuth.instance.currentUser.uid;
  void pdfMake(BuildContext context) async {
    if (image != null) {
      final img1 =
          PdfImage.file(pdf.document, bytes: File(image).readAsBytesSync());
      // final img1 = PdfImage.file(pdf.document, bytes: image.path. );
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          // ignore: deprecated_member_use
          child: pw.Image(img1),
        );
      }));
      final output = await getExternalStorageDirectory();
      print("${output.path}/example.pdf");
      file = File("${output.path}/Document.pdf");
      await file.writeAsBytes(pdf.save());
      debugPrint("12344443" + file.path);
    } else {
      showMessageDialog("Error", context);
    }
  }

  Future<void> uploadData(BuildContext context) {
    try {
      AppHelper.checkInternetConnection().then((isAvailable) async {
        if (isAvailable) {
          debugPrint("1");
          if (file != null) {
            debugPrint("2");
            var userIdVal = FirebaseAuth.instance.currentUser.uid;
            final reportId = Uuid().v4();
            Reference _storageReference = FirebaseStorage.instance.ref().child(
                "REPORT_PDF/$userIdVal/BLOOD_REPORT/$reportId/$reportName.pdf");
            await _storageReference.putFile(file);
            String link = await _storageReference.getDownloadURL();
            print("123     " + link);
            await FirebaseFirestore.instance
                .collection(USER_COLLECTION + "/$userIdVal/$reportFolderValue")
                .doc(reportId)
                .set({
              "blood_report_id": reportId,
              "blood_report_link": link,
              REPORT_NAME: reportNameValue,
              REPORT_FOLDER_NAME: reportFolderValue,
              REPORT_DESCRIPTION: reportDescriptionValue,
              REPORT_DATE: reportDateValue
            });
            showProgressChanged(false);
            showDialogAndNavigate(
                REPORT_ADDED_SUCCESSFULLY, context, HOME_SCREEN);
          }
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
                content: Text(e.message),
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
    _imageSelectedFromCamera?.close();
    _isKeyboardOpen?.close();
    _reportId?.close();
    _reportName?.close();
    _reportDescription?.close();
  }
}
