import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/daily_medicine_bloc/daily_medicine_detail_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineType extends StatelessWidget {
  final DailyMedicineBloc dailyMedicineBloc;

  const DailyMedicineType({Key key, @required this.dailyMedicineBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: dailyMedicineBloc.dailyMedicineType,
        builder: (context, snapshot) {
          String dropDownValue = 'Drops';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              color: ALICE_BLUE,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    dailyMedicineBloc.changeDailyMedicineType(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: ALICE_BLUE,
                    hintText: 'Type of Medicine',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
// DropdownButton<String>(
// value: dropDownValue,
// underline: Container(),
// icon: Icon(Icons.arrow_downward),
// iconSize: 20.0, // can be changed, default: 24.0
// iconEnabledColor: Colors.red,
// onChanged: (value) {
// dailyMedicineBloc.changeDailyMedicineType(value);
// },
// items: <String>['Drops', 'Capsules', 'Tablets', 'Liquid']
// .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// ),
