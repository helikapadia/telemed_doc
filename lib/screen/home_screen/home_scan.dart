import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeScan extends StatefulWidget {
  @override
  _HomeScanState createState() => _HomeScanState();
}

class _HomeScanState extends State<HomeScan> {
  File scannedDcoument;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, SCAN_DOC_ROUTE);
              // FlutterGeniusScan.scanWithConfiguration({
              //   'source': 'camera',
              //   'multiPage': true,
              // }).then((result) {
              //   String pdfUrl = result['pdfUrl'];
              //   OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
              //       (result) => debugPrint('$result'),
              //       onError: (error) => displayError(context, error));
              // }, onError: (error) => displayError(context, error));
            },
            child: Text(
              'Scan Documents',
              style: TextStyle(
                  fontFamily: 'Poppins', color: FONT_BLUE, fontSize: 14),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/Scan Doc..png',
                width: 140,
                height: 180,
              ),
            ],
          )
        ],
      ),
    );
  }

  void displayError(BuildContext context, PlatformException error) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
  }
}
