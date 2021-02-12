import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class UploadReportSubmit extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const UploadReportSubmit({Key key,@required this.uploadDocumentsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: uploadDocumentsBloc.submitReportDetail,
      builder: (context, snapshot) {
        bool isEnabled = snapshot.data ?? false;
        return FlatButton(
            onPressed: isEnabled
                ? () {
              uploadDocumentsBloc.uploadFile(context);
            }
                : null,
            child: Container(
              width: MediaQuery.of(context).size.width - 65,
              height: 50,
              //padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                color: isEnabled ? BUTTON_BLUE : Colors.grey,
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ));
      }
    );
  }
}
