// import 'dart:io';
//
// import 'package:document_scanner/document_scanner.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ScanDoc extends StatefulWidget {
//   @override
//   _ScanDocState createState() => _ScanDocState();
// }
//
// class _ScanDocState extends State<ScanDoc> {
//   File scannedDocument;
//   Future<PermissionStatus> cameraPermissionFuture;
//   Future<Map<Permission, PermissionStatus>> statuses;
//
//   @override
//   void initState() {
//     _requestPermission();
//     // cameraPermissionFuture = Permission.camera.request();
//     super.initState();
//   }
//
//   _requestPermission() {
//     statuses = [
//       Permission.camera,
//       Permission.storage,
//     ].request();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Map<Permission, PermissionStatus>>(
//           future: statuses,
//           builder: (BuildContext context,
//               AsyncSnapshot<Map<Permission, PermissionStatus>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               bool allGranted = snapshot.data[Permission.camera] ==
//                       PermissionStatus.granted &&
//                   snapshot.data[Permission.storage] == PermissionStatus.granted;
//               if (allGranted)
//                 return Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Expanded(
//                           child: scannedDocument != null
//                               ? Image(
//                                   image: FileImage(scannedDocument),
//                                 )
//                               : DocumentScanner(onDocumentScanned:
//                                   (ScannedImage scannedImage) {
//                                   print("document : " +
//                                       scannedImage.croppedImage);
//                                   setState(() {
//                                     scannedDocument =
//                                         scannedImage.getScannedDocumentAsFile();
//                                     // imageLocation = image;
//                                   });
//                                 }),
//                         ),
//                       ],
//                     ),
//                     scannedDocument != null
//                         ? Positioned(
//                             bottom: 20,
//                             left: 0,
//                             right: 0,
//                             child: RaisedButton(
//                                 child: Text('Retry'),
//                                 onPressed: () {
//                                   setState(() {
//                                     scannedDocument = null;
//                                   });
//                                 }),
//                           )
//                         : Container(),
//                   ],
//                 );
//               else
//                 return Center(
//                   child: Text("Camera permission denied"),
//                 );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_description.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_folder_selection.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_name.dart';
import 'package:telemed_doc/util/constant.dart';

class ScanDocScreen extends StatefulWidget {
  @override
  _ScanDocScreenState createState() => _ScanDocScreenState();
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan the Document'),
        backgroundColor: BG_BLUE2,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HOME_SCREEN, (route) => false);
              }),
        ),
      ),
      backgroundColor: ALICE_BLUE,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60, top: 10),
                          child: Text(
                            'Name of Document',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: FONT_BLUE,
                                fontSize: 20),
                          ),
                        ),
                        ScannedDocumentName(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Text(
                            'Description of Document',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: FONT_BLUE,
                                fontSize: 20),
                          ),
                        ),
                        ScannedDocumentDescription(),
                        Padding(
                          padding: const EdgeInsets.only(right: 85, top: 10),
                          child: Text(
                            'Select the Folder',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: FONT_BLUE,
                                fontSize: 20),
                          ),
                        ),
                        ScannedDocumentFolderSelection(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: IconButton(
                              icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 10,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
