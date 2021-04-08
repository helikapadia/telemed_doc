import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class UserDetailDob extends StatefulWidget {
  final UserProfileDetailBloc userProfileDetailBloc;
  final FocusNode dateOfBirthFocusNode;

  const UserDetailDob(
      {Key key,
      @required this.userProfileDetailBloc,
      this.dateOfBirthFocusNode})
      : super(key: key);

  @override
  _UserDetailDobState createState() => _UserDetailDobState();
}

class _UserDetailDobState extends State<UserDetailDob> {
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
          stream: widget.userProfileDetailBloc.dob,
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
                    widget.userProfileDetailBloc.changeDob(dobController.text);
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
                                  widget.userProfileDetailBloc.dobValue != null
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
    widget.userProfileDetailBloc.showProgress(true);
    DateTime dateTimeNow = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime(dateTimeNow.year - 13, dateTimeNow.month, dateTimeNow.day),
      firstDate: DateTime(1940, 4, 1),
      lastDate: DateTime(
        dateTimeNow.year - 13,
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

    widget.userProfileDetailBloc.showProgress(false);
    if (picked != null) {
      var formatter = DateFormat('yyyy-MM-dd');
      dobController.text = formatter.format(picked);
      widget.userProfileDetailBloc.changeDob(dobController.text);
    }
  }
}
