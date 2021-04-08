import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class UploadDocFolderSelection extends StatefulWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const UploadDocFolderSelection({Key key, this.uploadDocumentsBloc})
      : super(key: key);
  @override
  _UploadDocFolderSelectionState createState() =>
      _UploadDocFolderSelectionState();
}

class _UploadDocFolderSelectionState extends State<UploadDocFolderSelection> {
  var currentValue;

  @override
  Widget build(BuildContext context) {
    String dropDownValue = 'Pathological Report';

    return StreamBuilder<String>(
        stream: widget.uploadDocumentsBloc.reportFolder,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              color: ALICE_BLUE,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 90),
                child: DropdownButton<String>(
                  hint: Text('Select Folder'),
                  value: currentValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('Pathological Report'),
                      value: 'Pathological Report',
                    ),
                    DropdownMenuItem(
                      child: Text('Radiological Imaging'),
                      value: 'Radiological Imaging',
                    ),
                    DropdownMenuItem(
                      child: Text('Prescription'),
                      value: 'Prescription',
                    ),
                    DropdownMenuItem(
                      child: Text('Medical Policy'),
                      value: 'Medical Policy',
                    ),
                  ],
                  onChanged: (value) {
                    widget.uploadDocumentsBloc.reportFolderChanged(value);
                    setState(() {
                      currentValue =
                          widget.uploadDocumentsBloc.reportFolderValue;
                    });
                  },
                ),
              ),
            ),
          );
        });
  }
}
