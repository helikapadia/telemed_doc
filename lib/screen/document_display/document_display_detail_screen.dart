import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class DocumentDisplayDetailScreen extends StatefulWidget {
  @override
  _DocumentDisplayDetailScreenState createState() =>
      _DocumentDisplayDetailScreenState();
}

class _DocumentDisplayDetailScreenState
    extends State<DocumentDisplayDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var userIdVal = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user/$userIdVal/reports/")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Documents Detail'),
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
                  ListView(
                      //children: [Text(snapshot.data["report_name"])],
                      )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.share),
                onPressed: () {},
                backgroundColor: BG_BLUE2,
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
