import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class DocumentDisplay extends StatefulWidget {
  @override
  _DocumentDisplayState createState() => _DocumentDisplayState();
}

class _DocumentDisplayState extends State<DocumentDisplay> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
  }

  var userIdVal = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("user/$userIdVal/reports")
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
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
                          document = await PDFDocument.fromURL(
                              snapshot.data.docs[index]["blood_report_link"]);
                          print("1");
                          setState(() {
                            _isLoading = false;
                          });
                          print(snapshot.data.docs[index]["blood_report_link"]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.docs.length),
                Center(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : PDFViewer(document: document),
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
