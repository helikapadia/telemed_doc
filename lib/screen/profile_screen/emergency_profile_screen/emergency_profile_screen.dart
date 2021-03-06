import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class EmergencyProfileScreen extends StatefulWidget {
  @override
  _EmergencyProfileScreenState createState() => _EmergencyProfileScreenState();
}

class _EmergencyProfileScreenState extends State<EmergencyProfileScreen> {
  bool _status = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  var userId;
  void initState() {
    super.initState();
    input();
  }

  Future<void> input() async {
    FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
    setState(() {
      userId = userIdVal.uid;
    });
    return userId;
  }

  //var userIdVal = FirebaseAuth.instance.currentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_BLUE2,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PROFILE_DETAIL, (route) => false);
              }),
        ),
      ),
      backgroundColor: ALICE_BLUE,
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection(USER_COLLECTION)
            .document(userId)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("none");
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                _emailController.text = snapshot.data["emergency_email"];
                _phoneNumberController.text =
                    snapshot.data["emergency_phone_number"];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Emergency Contact Info',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _status ? _getEditIcon() : new Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Text(
                                    "Emergency Email:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                  title: TextFormField(
                                    validator: (Email) {
                                      if (RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(Email)) {
                                        return "Email cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (name) => _updateState,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Text(
                                    "Emergency Contact:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                  title: TextFormField(
                                    validator: (Phone) {
                                      if (Phone.isEmpty) {
                                        return "Phone Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _phoneNumberController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              case ConnectionState.done:
                _emailController.text = snapshot.data["emergency_email"];
                _phoneNumberController.text =
                    snapshot.data["emergency_phone_number"];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Emergency Contact Info',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _status ? _getEditIcon() : new Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Text(
                                    "Emergency Email:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                  title: TextFormField(
                                    validator: (Email) {
                                      if (RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(Email)) {
                                        return "Email cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (name) => _updateState,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Text(
                                    "Emergency Contact:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                  title: TextFormField(
                                    validator: (Phone) {
                                      if (Phone.isEmpty) {
                                        return "Phone Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _phoneNumberController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              default:
                return Container();
            }
            return Container();
          }
        },
      ),
    );
  }

  Widget _getActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: RaisedButton(
              child: Text("Save"),
              textColor: Colors.white,
              color: BUTTON_BLUE,
              onPressed: () async {
                setState(() {
                  _status = true;
                });
                if (_formKey.currentState.validate()) {
                  await Firestore.instance
                      .collection(USER_COLLECTION)
                      .document(userId)
                      .updateData({
                    "emergency_email": _emailController.text,
                    "emergency_phone_number": _phoneNumberController.text,
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: RaisedButton(
              child: Text("Cancel"),
              textColor: Colors.white,
              color: BUTTON_BLUE,
              onPressed: () {
                setState(() {
                  _status = true;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
