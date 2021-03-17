import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class DoctorDetailProfileScreen extends StatefulWidget {
  @override
  _DoctorDetailProfileScreenState createState() =>
      _DoctorDetailProfileScreenState();
}

class _DoctorDetailProfileScreenState extends State<DoctorDetailProfileScreen> {
  bool _status = true;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  void initState() {
    super.initState();
  }

  var userIdVal = FirebaseAuth.instance.currentUser.uid;
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
        stream: FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal)
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
                _fullNameController.text = snapshot.data["doctor_name"];
                _phoneNumberController.text =
                    snapshot.data["doctor_phone_number"];
                _addressController.text = snapshot.data["doctor_address"];
                _specializationController.text =
                    snapshot.data["doctor_specialization"];

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
                                    'Consulting Doctor Info',
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
                                    "Doctor Name:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Name) {
                                      if (Name.isEmpty) {
                                        return "Name cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _fullNameController,
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
                                    "Doctor Phone Number:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Phone) {
                                      if (Phone.isEmpty) {
                                        return "Phone Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
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
                                    "Doctor Clinic Address",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Address) {
                                      if (Address.isEmpty) {
                                        return "Address cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _addressController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
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
                                    "Doctor Specialization:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (specialization) {
                                      if (specialization.isEmpty) {
                                        return "Specialization cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _specializationController,
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
                _fullNameController.text = snapshot.data["doctor_name"];
                _phoneNumberController.text =
                    snapshot.data["doctor_phone_number"];
                _addressController.text = snapshot.data["doctor_address"];
                _specializationController.text =
                    snapshot.data["doctor_specialization"];

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
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Consulting Doctor Info',
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
                                    "Doctor Name:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Name) {
                                      if (Name.isEmpty) {
                                        return "Name cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _fullNameController,
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
                                    "Doctor Phone Number:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Phone) {
                                      if (Phone.isEmpty) {
                                        return "Phone Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
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
                                    "Doctor Clinic Address",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Address) {
                                      if (Address.isEmpty) {
                                        return "Address cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _addressController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
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
                                    "Doctor Specialization:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (specialization) {
                                      if (specialization.isEmpty) {
                                        return "Specialization cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _specializationController,
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
                  await FirebaseFirestore.instance
                      .collection(USER_COLLECTION)
                      .doc(userIdVal)
                      .update({
                    "doctor_name": _fullNameController.text,
                    "doctor_phone_number": _phoneNumberController.text,
                    "doctor_address": _addressController.text,
                    "doctor_specialization": _specializationController.text,
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
