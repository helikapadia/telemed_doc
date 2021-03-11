import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';

class UploadReportPDF extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const UploadReportPDF({Key key, this.uploadDocumentsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //     stream: uploadDocumentsBloc.fileUrl,
    //     builder: (context, snapshot) {
    //bool isEnabled = snapshot.data ?? false;
    return Container(
      alignment: Alignment.bottomRight,
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      child: FlatButton(
          child: Card(
            child: Center(
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
          onPressed: () {
            uploadDocumentsBloc.selectPdf(context);
          }),
    );
    // });
  }
}
