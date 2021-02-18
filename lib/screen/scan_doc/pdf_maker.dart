// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// class ScanDocument extends StatefulWidget {
//   @override
//   _ScanDocumentState createState() => _ScanDocumentState();
// }
//
// class _ScanDocumentState extends State<ScanDocument> {
//   File _image;
//   File _tempImage;
//   final pdf = pw.Document();
//   int index;
//
//   Future getImageCamera() async {
//     // ignore: deprecated_member_use
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (_image == null) {
//         _image = image;
//       } else {
//         _tempImage = _image;
//         _image = image;
//       }
//     });
//   }
//
//   void createPDF(File _image) async {
//     var userIdVal = FirebaseAuth.instance.currentUser.uid;
//     final image = PdfImage.file(
//       pdf.document,
//       bytes: _image.readAsBytesSync(),
//     );
//     pdf.addPage(pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Image(image),
//           ); // Center
//         }));
//     final output = await FirebaseFirestore.instance
//         .collection("user/$userIdVal/reports")
//         .snapshots();
//     final file = File("$output");
//     index = index + 1;
//     await file.writeAsBytes(await pdf.save());
//     // await Printing.layoutPdf(
//     //     onLayout: (PdfPageFormat format) async => pdf.save());
//     //   await Printing.sharePdf(bytes: pdf.save(), filename: 'my-document.pdf');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
