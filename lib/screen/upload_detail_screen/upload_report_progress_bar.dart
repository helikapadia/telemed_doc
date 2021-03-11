import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/component/modal_progress_bar/modal_progress_bar.dart';

class UploadReportProgressBar extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const UploadReportProgressBar({Key key, this.uploadDocumentsBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: uploadDocumentsBloc.Progress,
        builder: (context, snapshot) {
          return ModalProgressBar(
            inAsyncCall: uploadDocumentsBloc.showProgressValue,
            child: Container(),
          );
        });
  }
}
