import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/app_helper.dart';

class ViewPdfBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _file = BehaviorSubject<File>();
  final _isPreviewReady = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get showProgress => _showProgress.stream;
  Stream<File> get file => _file.stream;
  Stream<bool> get isPreviewReady => _isPreviewReady.stream;

  bool get progressValue => _showProgress.stream.value;
  File get fileValue => _file.stream.value;
  bool get isPreviewReadyValue => _isPreviewReady.stream.value;

  Function(bool) get changeProgress => _showProgress.sink.add;
  Function(File) get changeFile => _file.sink.add;
  Function(bool) get isPreviewReadyChanged => _isPreviewReady.sink.add;

  final UploadDocumentsBloc uploadDocumentsBloc = UploadDocumentsBloc();
  Future<void> downloadFile(url) async {
    changeProgress(false);
    await AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        try {
          var data = await http.get(url);
          var bytes = data.bodyBytes;
          var dir = await getApplicationDocumentsDirectory();
          var userIdVal = FirebaseAuth.instance.currentUser.uid;
          var reportId = uploadDocumentsBloc.reportIdValue;
          print(reportId);
          File file = File(
              "REPORT_PDF/$userIdVal/BLOOD_REPORT/$reportId/BLOOD_REPORT.pdf");
          File tempFile = await file.writeAsBytes(bytes);
          changeProgress(false);
          changeFile(tempFile);
        } on Exception catch (e) {
          changeProgress(false);
        }
      } else {
        changeProgress(false);
      }
    });
  }

  void dispose() {
    _file.close();
    _showProgress.close();
    _isPreviewReady?.close();
  }
}
