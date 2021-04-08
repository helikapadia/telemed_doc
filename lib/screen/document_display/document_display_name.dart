import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DocumentDisplayName extends StatefulWidget {
  @override
  _DocumentDisplayNameState createState() => _DocumentDisplayNameState();
}

class _DocumentDisplayNameState extends State<DocumentDisplayName> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userIdVal = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user/$userIdVal/reports/")
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              title: Text('Report Name:'),
              //subtitle: Text(snapshot.data.docs["report_name"]),
            );
          }
        });
  }
}
