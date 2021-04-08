import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/view_pdf_bloc/view_pdf_bloc.dart';
import 'package:telemed_doc/component/modal_progress_bar/modal_progress_bar.dart';
import 'package:telemed_doc/util/constant.dart';

class ViewPDF extends StatefulWidget {
  final String pdfUrl;

  const ViewPDF({Key key, this.pdfUrl}) : super(key: key);

  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  ViewPdfBloc viewPdfBloc = ViewPdfBloc();
  bool pdfReady = false;

  @override
  void initState() {
    debugPrint(widget.pdfUrl);
    super.initState();
    if (widget.pdfUrl != null) {
      debugPrint(widget.pdfUrl);
    }
    viewPdfBloc.downloadFile(widget.pdfUrl);
  }

  @override
  void dispose() {
    viewPdfBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_BLUE2,
        title: Text('Report'),
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, UPLOAD_DETAIL_SCREEN, (route) => false);
              }),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Material(
          child: StreamBuilder<File>(
            stream: viewPdfBloc.file,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return PDFView(
                //   filePath: viewPdfBloc.fileValue?.path,
                //   autoSpacing: true,
                //   pageSnap: true,
                //   swipeHorizontal: false,
                //   nightMode: false,
                //   onRender: (_pages) {
                //     pdfReady = true;
                //     viewPdfBloc.changeProgress(false);
                //   },
                //   onViewCreated: (view) {},
                //   onPageChanged: (page, totalPage) {},
                //   onPageError: (page, e) {
                //     debugPrint("Error $e");
                //   },
                // );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Unable to load PDF",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
              return ModalProgressBar(inAsyncCall: true, child: Container());
            },
          ),
        ),
      ),
    );
  }
}
