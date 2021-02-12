import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/daily_medicine_bloc/daily_medicine_detail_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineSubmitBtn extends StatelessWidget {
  final DailyMedicineBloc dailyMedicineBloc;

  const DailyMedicineSubmitBtn({Key key, @required this.dailyMedicineBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: dailyMedicineBloc.submitDailyMedicine,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;
          return FlatButton(
              onPressed: isEnabled
                  ? () {
                      dailyMedicineBloc.addDailyMedicine(context);
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
