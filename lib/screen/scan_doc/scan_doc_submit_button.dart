import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ScanDocSubmit extends StatelessWidget {
  final ScanBloc scanBloc;

  const ScanDocSubmit({Key key, this.scanBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: scanBloc.submitCheck,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;
          return TextButton(
              onPressed: isEnabled
                  ? () {
                      scanBloc.pdfMake(context);
                      scanBloc.uploadData(context);
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
        });
  }
}
