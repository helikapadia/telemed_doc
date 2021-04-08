import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineProfileScreen extends StatefulWidget {
  @override
  _DailyMedicineProfileScreenState createState() =>
      _DailyMedicineProfileScreenState();
}

class _DailyMedicineProfileScreenState
    extends State<DailyMedicineProfileScreen> {
  bool _status = true;
  TextEditingController _medicineNumberController = TextEditingController();
  TextEditingController _medicineNameController = TextEditingController();
  TextEditingController _medicineTypeController = TextEditingController();
  TextEditingController _medicineDosageController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  var userId;
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
                    context, PROFILE_TAB_SCREEN, (route) => false);
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
                _medicineNumberController.text =
                    snapshot.data["medicine_number"];
                _medicineNameController.text = snapshot.data["medicine_name"];
                _medicineTypeController.text = snapshot.data["medicine_type"];
                _medicineDosageController.text =
                    snapshot.data["medicine_dosage"];

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
                                    'Daily Medicine Information',
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
                                    "Medicine Number:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Number) {
                                      if (Number.isEmpty) {
                                        return "Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineNumberController,
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
                                    "Medicine Name:",
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
                                    controller: _medicineNameController,
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
                                    "Medicine Type:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Type) {
                                      if (Type.isEmpty) {
                                        return "Type cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineTypeController,
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
                                    "Dosage:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (dosage) {
                                      if (dosage.isEmpty) {
                                        return "Dosage cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineDosageController,
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
                _medicineNumberController.text =
                    snapshot.data["medicine_number"];
                _medicineNameController.text = snapshot.data["medicine_name"];
                _medicineTypeController.text = snapshot.data["medicine_type"];
                _medicineTypeController.text = snapshot.data["medicine_dosage"];

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
                                    'Daily Medicine Information',
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
                                    "Medicine Number:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Number) {
                                      if (Number.isEmpty) {
                                        return "Number cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineNumberController,
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
                                    "Medicine Name:",
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
                                    controller: _medicineNameController,
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
                                    "Medicine Type:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (Type) {
                                      if (Type.isEmpty) {
                                        return "Type cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineTypeController,
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
                                    "Dosage:",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                  title: TextFormField(
                                    validator: (dosage) {
                                      if (dosage.isEmpty) {
                                        return "Dosage cannot be empty";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    enabled: !_status,
                                    controller: _medicineDosageController,
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
                if (_formKey.currentState.validate()) {
                  await FirebaseFirestore.instance
                      .collection(USER_COLLECTION)
                      .doc(userIdVal)
                      .update({
                    "medicine_number": _medicineNumberController.text,
                    "medicine_name": _medicineNameController.text,
                    "medicine_type": _medicineTypeController.text,
                    "medicine_dosage": _medicineDosageController.text,
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
