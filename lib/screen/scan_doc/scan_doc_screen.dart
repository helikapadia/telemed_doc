import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';
import 'package:telemed_doc/screen/scan_doc/add_image.dart';
import 'package:telemed_doc/screen/scan_doc/scan_doc_report_date.dart';
import 'package:telemed_doc/screen/scan_doc/scan_doc_submit_button.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_description.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_folder_selection.dart';
import 'package:telemed_doc/screen/scan_doc/scanned_document_name.dart';
import 'package:telemed_doc/util/constant.dart';

class ScanDocScreen extends StatefulWidget {
  @override
  _ScanDocScreenState createState() => _ScanDocScreenState();
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  ScanBloc scanBloc = ScanBloc();
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                              padding:
                                  const EdgeInsets.only(right: 60, top: 10),
                              child: Text(
                                'Name of Document',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: FONT_BLUE,
                                    fontSize: 20),
                              ),
                            ),
                            ScannedDocumentName(scanBloc: scanBloc),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: Text(
                                'Description of Document',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: FONT_BLUE,
                                    fontSize: 20),
                              ),
                            ),
                            ScannedDocumentDescription(scanBloc: scanBloc),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 85, top: 10),
                              child: Text(
                                'Select the Folder',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: FONT_BLUE,
                                    fontSize: 20),
                              ),
                            ),
                            ScannedDocumentFolderSelection(scanBloc: scanBloc),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 85, top: 10),
                              child: Text(
                                'Date of the Report',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: FONT_BLUE,
                                    fontSize: 20),
                              ),
                            ),
                            ScanDocReportDate(scanBloc: scanBloc),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 85, top: 10),
                              child: Text(
                                'Add Attachment',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: FONT_BLUE,
                                    fontSize: 20),
                              ),
                            ),
                            AddImage(scanBloc: scanBloc),
                            const SizedBox(
                              height: 20,
                            )
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8.0, vertical: 10),
                            //   child: IconButton(
                            //       icon: Icon(
                            //     Icons.add,
                            //     color: Colors.grey,
                            //     size: 10,
                            //   )),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ScanDocSubmit(scanBloc: scanBloc),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
