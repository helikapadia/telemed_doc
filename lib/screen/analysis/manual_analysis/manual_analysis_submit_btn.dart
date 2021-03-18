import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/manual_analysis_bloc/manual_analysis_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ManualAnalysisSubmitButton extends StatelessWidget {
  final ManualAnalysisBloc manualAnalysisBloc;

  const ManualAnalysisSubmitButton({Key key, this.manualAnalysisBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: manualAnalysisBloc.submitCheck,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;
          return FlatButton(
              onPressed: isEnabled
                  ? () {
                      manualAnalysisBloc.submitManualData(context);
                    }
                  : null,
              child: Container(
                width: MediaQuery.of(context).size.width - 65,
                height: 50,
                //padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  color: isEnabled ? BUTTON_BLUE : Colors.grey,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ));
        });
  }
}
