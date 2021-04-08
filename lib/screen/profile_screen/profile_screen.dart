import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileBloc profileBloc;

  const ProfileScreen({Key key, this.profileBloc}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
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
                _fullNameController.text = snapshot.data["fullName"];
                _emailController.text = snapshot.data["email"];
                _genderController.text = snapshot.data["gender"];
                _phoneNumberController.text = snapshot.data["phone_number"];
                _cityController.text = snapshot.data["city"];
                _ageController.text = snapshot.data["age"];
                _dobController.text = snapshot.data["dob"];
                _bloodGroupController.text = snapshot.data["blood_group"];
                _allergyController.text = snapshot.data["allergies"];
                _troubleController.text = snapshot.data["troubles"];
                _familyHistoryController.text = snapshot.data["family_history"];

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
                                    "Email:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
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
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _emailController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const Size
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
                                    "Phone Number:",
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
                                    "Age:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Age) {
                                      if (Age.isEmpty) {
                                        return "Age cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _ageController,
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
                _fullNameController.text = snapshot.data["fullName"];
                _emailController.text = snapshot.data["email"];
                _genderController.text = snapshot.data["gender"];
                _phoneNumberController.text = snapshot.data["phone_number"];
                _cityController.text = snapshot.data["city"];
                _ageController.text = snapshot.data["age"];
                _dobController.text = snapshot.data["dob"];
                _bloodGroupController.text = snapshot.data["blood_group"];
                _allergyController.text = snapshot.data["allergies"];
                _troubleController.text = snapshot.data["troubles"];
                _familyHistoryController.text = snapshot.data["family_history"];

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
                                    "Email:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
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
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _emailController,
                                    onChanged: (name) => _updateState,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const Size
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
                                    "Phone Number:",
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
                                    "Age:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Age) {
                                      if (Age.isEmpty) {
                                        return "Age cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _ageController,
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
                    "fullName": _fullNameController.text,
                    "email": _emailController.text,
                    "age": _ageController.text,
                    "gender": _genderController.text,
                    "phone_number": _phoneNumberController.text,
                    "dob": _dobController.text,
                    "blood_group": _bloodGroupController.text,
                    "allergies": _allergyController.text,
                    "troubles": _troubleController.text,
                    "family_history": _familyHistoryController.text
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
// body: Stack(
//   children: [
//     SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           // ProfileName(
//           //   profileBloc: profileBloc,
//           // ),
//           // ProfileEmail(profileBloc: profileBloc),
//           // ProfileGender(profileBloc: profileBloc),
//           // ProfileAge(profileBloc: profileBloc),
//           // ProfileDOB(profileBloc: profileBloc),
//           // ProfilePhoneNumber(profileBloc: profileBloc),
//           // ProfileBloodGroup(profileBloc: profileBloc),
//           // ProfileAllergies(profileBloc: profileBloc),
//           // ProfileTroubles(profileBloc: profileBloc),
//         ],
//       ),
//     ),
//   ],
// ),
