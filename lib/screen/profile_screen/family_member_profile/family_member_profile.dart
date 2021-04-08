import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class FamilyMemberProfileScreen extends StatefulWidget {
  @override
  _FamilyMemberProfileScreenState createState() =>
      _FamilyMemberProfileScreenState();
}

class _FamilyMemberProfileScreenState extends State<FamilyMemberProfileScreen> {
  bool _status = true;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _allergyController = TextEditingController();
  TextEditingController _troubleController = TextEditingController();
  TextEditingController _familyHistoryController = TextEditingController();

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
                    context, HOME_SCREEN, (route) => false);
              }),
        ),
      ),
      backgroundColor: ALICE_BLUE,
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection("family").doc().snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasError) {
            return Text("No Member");
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("none");
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                _fullNameController.text = snapshot.data["fam_fullName"];
                _genderController.text = snapshot.data["gender"];
                _dobController.text = snapshot.data["fam_dob"];
                _bloodGroupController.text = snapshot.data["fam_blood_group"];
                _allergyController.text = snapshot.data["fam_allergies"];
                _troubleController.text = snapshot.data["fam_troubles"];
                _familyHistoryController.text =
                    snapshot.data["fam_family_history"];

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
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    'Personal Information',
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
                                //ProfileEmail(profileBloc: widget.profileBloc),
                                ListTile(
                                  leading: Text(
                                    "Name:",
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
                                    "Gender:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Gender) {
                                      if (Gender.isEmpty) {
                                        return "Gender cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _genderController,
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
                                    "Date of Birth:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (dob) {
                                      if (dob.isEmpty) {
                                        return "Date of Birth cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _dobController,
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
                                    "Blood Group:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (BloodGrp) {
                                      if (BloodGrp.isEmpty) {
                                        return "Blood Group cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _bloodGroupController,
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
                                    "Allergies:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Allergy) {
                                      if (Allergy.isEmpty) {
                                        return "Allergy cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _allergyController,
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
                                    "Any Troubles:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Trouble) {
                                      if (Trouble.isEmpty) {
                                        return "Troubles cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _troubleController,
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
                                    "Family History:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (FamilyHistory) {
                                      if (FamilyHistory.isEmpty) {
                                        return "Troubles cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _familyHistoryController,
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
                _fullNameController.text = snapshot.data["fam_fullName"];
                _genderController.text = snapshot.data["fam_gender"];
                _dobController.text = snapshot.data["fam_dob"];
                _bloodGroupController.text = snapshot.data["fam_blood_group"];
                _allergyController.text = snapshot.data["fam_allergies"];
                _troubleController.text = snapshot.data["fam_troubles"];
                _familyHistoryController.text =
                    snapshot.data["fam_family_history"];

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
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    'Personal Information',
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
                                    "Name:",
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
                                    "Gender:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Gender) {
                                      if (Gender.isEmpty) {
                                        return "Gender cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _genderController,
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
                                    "Date of Birth:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (dob) {
                                      if (dob.isEmpty) {
                                        return "Date of Birth cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _dobController,
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
                                    "Blood Group:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (BloodGrp) {
                                      if (BloodGrp.isEmpty) {
                                        return "Blood Group cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _bloodGroupController,
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
                                    "Allergies:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Allergy) {
                                      if (Allergy.isEmpty) {
                                        return "Allergy cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _allergyController,
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
                                    "Any Troubles:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Trouble) {
                                      if (Trouble.isEmpty) {
                                        return "Troubles cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _troubleController,
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
                                    "Family History:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (FamilyHistory) {
                                      if (FamilyHistory.isEmpty) {
                                        return "Troubles cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _familyHistoryController,
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
            // ignore: deprecated_member_use
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
                    "fam_fullName": _fullNameController.text,
                    "fam_gender": _genderController.text,
                    "fam_dob": _dobController.text,
                    "fam_blood_group": _bloodGroupController.text,
                    "fam_allergies": _allergyController.text,
                    "fam_troubles": _troubleController.text,
                    "fam_family_history": _familyHistoryController.text
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
            // ignore: deprecated_member_use
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
      onTap: () {
        setState(() {
          _status = false;
        });
      },
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
