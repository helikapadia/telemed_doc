import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_report_submit.dart';
import 'package:telemed_doc/util/constant.dart';

class UploadReportDescription extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const UploadReportDescription({Key key,@required this.uploadDocumentsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: uploadDocumentsBloc.reportDescription,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Card(
            color: ALICE_BLUE,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                autocorrect: false,
                autofocus: true,
                enableSuggestions: false,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                onChanged: (value){
                  uploadDocumentsBloc.reportDescriptionChanged(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: ALICE_BLUE,
                  hintText: 'Description of the Report',
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
