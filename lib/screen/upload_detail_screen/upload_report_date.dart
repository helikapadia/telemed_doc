import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class UploadReportDate extends StatefulWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;
  final FocusNode dateFocusNode;

  const UploadReportDate(
      {Key key, this.uploadDocumentsBloc, this.dateFocusNode})
      : super(key: key);

  @override
  _UploadReportDateState createState() => _UploadReportDateState();
}

class _UploadReportDateState extends State<UploadReportDate> {
  TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    dateController?.dispose();
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
          stream: widget.uploadDocumentsBloc.reportDate,
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
                  controller: dateController,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    widget.uploadDocumentsBloc
                        .reportDateChanged(dateController.text);
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
                                  widget.uploadDocumentsBloc.reportDateValue !=
                                      null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                      labelText: 'Date of Report',
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
    widget.uploadDocumentsBloc.showProgress(true);
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

    widget.uploadDocumentsBloc.showProgress(false);
    if (picked != null) {
      var formatter = DateFormat('yyyy-MM-dd');
      dateController.text = formatter.format(picked);
      widget.uploadDocumentsBloc.reportDateChanged(dateController.text);
    }
  }
}
