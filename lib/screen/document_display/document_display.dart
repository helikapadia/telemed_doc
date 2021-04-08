import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/bloc/view_pdf_bloc/view_pdf_progress_bar_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DocumentDisplay extends StatefulWidget {
  final String filePath;

  const DocumentDisplay({Key key, this.filePath}) : super(key: key);
  @override
  _DocumentDisplayState createState() => _DocumentDisplayState();
}

class _DocumentDisplayState extends State<DocumentDisplay> {
  ViewPDFProgressBarBloc viewPDFProgressBarBloc = ViewPDFProgressBarBloc();
  bool _isLoading = true;
  UploadDocumentsBloc uploadDocumentsBloc = UploadDocumentsBloc();
  ScanBloc scanBloc = ScanBloc();

  @override
  void initState() {
    super.initState();
    viewPDFProgressBarBloc.getData(widget.filePath);
  }

  var userIdVal = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    var reportFolder = scanBloc.reportFolderValue;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("user/$userIdVal/reports/")
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Documents'),
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
              backgroundColor: BG_BLUE2,
            ),
            backgroundColor: ALICE_BLUE,
            body: Stack(
              children: [
                ListView.separated(
                    itemBuilder: (context, index) {
                      print(snapshot.data);
                      return ListTile(
                        title: Text(
                          snapshot.data.docs[index]["report_name"],
                        ),
                        onTap: () async {
                          PDFViewerScaffold(
                            path:
                                " https://firebasestorage.googleapis.com/v0/b/telemed-doc-b4414.appspot.com/o/REPORT_PDF%2FeMmKcqn7RKWurC8Mm5VIYV85XF92%2FBLOOD_REPORT%2F02a1721d-0fd5-446a-91c5-6abe6e81378f%2FBLOOD_REPORT.pdf?alt=media&token=a042c07b-75a1-48fc-86c8-634c3be4f3a7",
                          );
                          // PdfView(
                          //   physics: NeverScrollableScrollPhysics(),
                          //   documentLoader:
                          //       Center(child: CircularProgressIndicator()),
                          //   pageLoader:
                          //       Center(child: CircularProgressIndicator()),
                          //   controller: _pdfController,
                          //   // onDocumentLoaded: (document) {
                          //   //   setState(() {
                          //   //     _allPagesCount = document.pagesCount;
                          //   //   });
                          //   // },
                          //   // onPageChanged: (page) {
                          //   //   setState(() {
                          //   //     _actualPageNumber = page;
                          //   //   });
                          //   // },
                          // );
                          print(snapshot.data.docs[index]
                              .get("blood_report_link"));
                        },

                        // trailing: IconButton(
                        //     icon: Icon(
                        //       Icons.chevron_right,
                        //       color: Colors.grey,
                        //     ),
                        //     onPressed: () {
                        //       // Navigator.pushNamed(
                        //       //     context, DOCUMENT_DISPLAY_DETAIL_SCREEN);
                        //       MaterialPageRoute(builder: (context) {
                        //         return ViewPDF(
                        //           pdfUrl: snapshot.data.docs[index]
                        //               ["blood_report_link"],
                        //         );
                        //       });
                        //     }),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.docs.length),
                Center(
                  child: _isLoading
                      ? Center(
                          // child: CircularProgressIndicator(),
                          )
                      : null,
                )
              ],
            ),
          );
        } else {
          return Container();
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
        }
      },
    );
  }
}
//document = await PDFDocument.fromURL(
//                               snapshot.data.docs[index]["blood_report_link"]);
//                           print("1");
//                           setState(() {
//                             _isLoading = false;
//                           });
//                           print(snapshot.data.docs[index]["blood_report_link"]);
//PDFViewer(document: document)

//pdfView : 8/4/2021 onTap: () async {
// PDFView(
// filePath: snapshot.data.docs[index]
// .data()["blood_report_link"],
// enableSwipe: true,
// swipeHorizontal: false,
// pageFling: true,
// onRender: (_pages) {
// viewPDFProgressBarBloc.changeProgress(false);
// },
// );
// print(snapshot.data.docs[index]
// .get("blood_report_link"));
// },
