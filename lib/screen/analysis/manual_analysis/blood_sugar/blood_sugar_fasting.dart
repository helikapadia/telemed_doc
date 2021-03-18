import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/manual_analysis_bloc/manual_analysis_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class BloodSugarFasting extends StatelessWidget {
  final ManualAnalysisBloc manualAnalysisBloc;

  const BloodSugarFasting({Key key, this.manualAnalysisBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: manualAnalysisBloc.bsFast,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              color: ALICE_BLUE,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    manualAnalysisBloc.changeBsFast(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: ALICE_BLUE,
                    hintText: 'Fasting Sugar (mg/dL)',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
