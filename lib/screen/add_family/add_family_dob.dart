import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class AddFamilyDOB extends StatefulWidget {
  final FocusNode dateOfBirthFocusNode;
  final AddFamilyBloc addFamilyBloc;

  const AddFamilyDOB({Key key, this.dateOfBirthFocusNode, this.addFamilyBloc})
      : super(key: key);
  @override
  _AddFamilyDOBState createState() => _AddFamilyDOBState();
}

class _AddFamilyDOBState extends State<AddFamilyDOB> {
  TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    dobController?.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) {
    if (Platform.isAndroid) {
      showMaterialDatePicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: StreamBuilder<String>(
          stream: widget.addFamilyBloc.dob,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  enabled: false,
                  autocorrect: false,
                  autofocus: true,
                  enableSuggestions: false,
                  controller: dobController,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    widget.addFamilyBloc.changeDob(dobController.text);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      suffixIcon: snapshot.hasError
                          ? Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : !snapshot.hasError &&
                                  widget.addFamilyBloc.dobValue != null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                      labelText: DATE_OF_BIRTH,
                      labelStyle: const TextStyle(color: Color(0xFFA9A9A9))),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: FONT_BLUE,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> showMaterialDatePicker() async {
    widget.addFamilyBloc.showProgress(true);
    DateTime dateTimeNow = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day),
      firstDate: DateTime(1940, 4, 1),
      lastDate: DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day,
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: BLUE,
            accentColor: Colors.blue,
            dialogBackgroundColor: Colors.white,
            textTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(color: Colors.black),
                // ignore: deprecated_member_use
                subhead: TextStyle(color: Colors.black),
                // ignore: deprecated_member_use
                body1: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          child: child,
        );
      },
    );

    widget.addFamilyBloc.showProgress(false);
    if (picked != null) {
      var formatter = DateFormat('yyyy-MM-dd');
      dobController.text = formatter.format(picked);
      widget.addFamilyBloc.changeDob(dobController.text);
    }
  }
}
