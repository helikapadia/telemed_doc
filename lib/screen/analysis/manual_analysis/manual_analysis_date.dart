import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telemed_doc/bloc/manual_analysis_bloc/manual_analysis_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ManualAnalysisDate extends StatefulWidget {
  final ManualAnalysisBloc manualAnalysisBloc;
  final FocusNode dateFocusNode;

  const ManualAnalysisDate(
      {Key key, this.manualAnalysisBloc, this.dateFocusNode})
      : super(key: key);
  @override
  _ManualAnalysisDateState createState() => _ManualAnalysisDateState();
}

class _ManualAnalysisDateState extends State<ManualAnalysisDate> {
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
          stream: widget.manualAnalysisBloc.analysisDate,
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
                    widget.manualAnalysisBloc
                        .changeAnalysisDate(dateController.text);
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
                                  widget.manualAnalysisBloc.analysisDateValue !=
                                      null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                      labelText: 'Date of the Analysis',
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
    widget.manualAnalysisBloc.showProgress;
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

    widget.manualAnalysisBloc.showProgress;
    if (picked != null) {
      var formatter = DateFormat('yyyy-MM-dd');
      dateController.text = formatter.format(picked);
      widget.manualAnalysisBloc.changeAnalysisDate(dateController.text);
    }
  }
}
