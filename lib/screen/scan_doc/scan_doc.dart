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
