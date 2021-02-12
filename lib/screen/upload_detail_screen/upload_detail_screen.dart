import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_detail_design.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_report_description.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_report_submit.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_report_title.dart';
import 'package:telemed_doc/util/constant.dart';

class UploadDetailScreen extends StatefulWidget {
  @override
  _UploadDetailScreenState createState() => _UploadDetailScreenState();
}

class _UploadDetailScreenState extends State<UploadDetailScreen> {
  UploadDocumentsBloc uploadDocumentsBloc = UploadDocumentsBloc();
  @override
  void dispose(){
    uploadDocumentsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UploadDetailDesign(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 130, top: 10),
                          child: Text(
                            'Title of Report',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: FONT_BLUE,
                                fontSize: 20),
                          ),
                        ),
                        UploadReportTitle(uploadDocumentsBloc: uploadDocumentsBloc,),
                        Padding(
                          padding: const EdgeInsets.only(right: 150, top: 10),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: FONT_BLUE,
                                fontSize: 20),
                          ),
                        ),
                        UploadReportDescription(uploadDocumentsBloc: uploadDocumentsBloc),
                        const SizedBox(
                          height: 20,
                        ),
                        UploadReportSubmit(uploadDocumentsBloc: uploadDocumentsBloc),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
