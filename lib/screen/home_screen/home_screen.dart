import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/screen/drawer/home_drawer.dart';
import 'package:telemed_doc/screen/home_screen/home_analysis.dart';
import 'package:telemed_doc/screen/home_screen/home_profile.dart';
import 'package:telemed_doc/screen/home_screen/home_scan.dart';
import 'package:telemed_doc/screen/home_screen/home_screen_design.dart';
import 'package:telemed_doc/screen/home_screen/home_search.dart';
import 'package:telemed_doc/screen/home_screen/home_upload.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UploadDocumentsBloc uploadDocumentsBloc = UploadDocumentsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight),
      //   child: AppBar(
      //     leading: Builder(
      //       builder: (context) => IconButton(
      //           icon: Icon(
      //             Icons.menu,
      //             color: Colors.white,
      //           ),
      //           onPressed: () {
      //             Scaffold.of(context).openDrawer();
      //           }),
      //     ),
      //     backgroundColor: BG_BLUE1,
      //   ),
      // ),
      drawer: HomeDrawer(),
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeScreenDesign(),
                HomeSearch(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeScan(),
                    HomeUpload(
                      uploadDocumentsBloc: uploadDocumentsBloc,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeAnalysis(),
                    HomeProfile(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
