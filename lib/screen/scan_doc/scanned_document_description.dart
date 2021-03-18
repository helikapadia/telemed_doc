import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ScannedDocumentDescription extends StatelessWidget {
  final ScanBloc scanBloc;

  const ScannedDocumentDescription({Key key, this.scanBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: scanBloc.reportDescription,
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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    scanBloc.reportDescriptionChanged(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: ALICE_BLUE,
                    hintText: 'Description of Report',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
