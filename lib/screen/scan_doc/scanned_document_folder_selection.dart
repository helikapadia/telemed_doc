import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ScannedDocumentFolderSelection extends StatefulWidget {
  final ScanBloc scanBloc;
  const ScannedDocumentFolderSelection({Key key, this.scanBloc})
      : super(key: key);

  @override
  _ScannedDocumentFolderSelectionState createState() =>
      _ScannedDocumentFolderSelectionState();
}

class _ScannedDocumentFolderSelectionState
    extends State<ScannedDocumentFolderSelection> {
  var currentValue;

  @override
  Widget build(BuildContext context) {
    String dropDownValue = 'Blood Report';

    return StreamBuilder<String>(
        stream: widget.scanBloc.reportFolder,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              color: ALICE_BLUE,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 110),
                child: DropdownButton<String>(
                  hint: Text('Select the Folder'),
                  value: currentValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('Blood Report'),
                      value: 'Blood Report',
                    ),
                    DropdownMenuItem(
                      child: Text('X-Ray'),
                      value: 'X-Ray',
                    ),
                    DropdownMenuItem(
                      child: Text('CT Scan'),
                      value: 'CT Scan',
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
                    widget.scanBloc.reportFolderChanged(value);
                    setState(() {
                      currentValue = widget.scanBloc.reportFolderValue;
                    });
                  },
                ),
              ),
            ),
          );
        });
  }
}
