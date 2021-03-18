import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHelper {
  static void popupDialog(
      BuildContext context, String alertTitle, String alertBody) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(alertTitle),
            content: Text(alertBody),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('close'))
            ],
          );
        });
  }

  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}

void showMessageDialog(String msg, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              textStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
              child: Text('OK'),
            )
          ],
        );
      });
}

void showDialogAndNavigate(String msg, BuildContext context, String routeName) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: TextStyle(fontSize: 14, fontFamily: "Poppins"),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.pushNamed(context, routeName);
                },
                textStyle: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                child: Text("OK"))
          ],
        );
      });
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void showDialogAndRemoveRoutes(
    String msg, BuildContext context, String routeName) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, routeName, (route) => false);
              },
              textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              child: Text("OK"),
            )
          ],
        );
      });
}

class ReportModel {
  const ReportModel(
      {@required this.reportUrl,
      @required this.reportDate,
      @required this.reportName});

  final List<String> reportUrl;
  final String reportDate;
  final List<String> reportName;
}

class ReportPDFUploadModel {
  const ReportPDFUploadModel(
      {@required this.filePath, @required this.epochTime});

  final String filePath;
  final String epochTime;
}

class PDFHelperModel {
  const PDFHelperModel({@required this.title, @required this.pdfUrl});

  final String title;
  final String pdfUrl;
}

class PreviewPhotoOnlineModel {
  const PreviewPhotoOnlineModel(
      {@required this.imageList, @required this.index});
  final List<String> imageList;
  final int index;
}

class PickedImageModel {
  const PickedImageModel(
      {@required this.isFromLib,
      @required this.img,
      @required this.identifier,
      @required this.epochTimeStamp});
  final bool isFromLib;
  final dynamic img;
  final String identifier;
  final String epochTimeStamp;
}

class PickedImageNewMessageModel {
  const PickedImageNewMessageModel(
      {@required this.isFromLib,
      @required this.img,
      @required this.identifier,
      @required this.epochTimeStamp});
  final bool isFromLib;
  final dynamic img;
  final String identifier;
  final String epochTimeStamp;
}
