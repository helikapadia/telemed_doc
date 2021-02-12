import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/daily_medicine_bloc/daily_medicine_detail_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineType extends StatelessWidget {
  final DailyMedicineBloc dailyMedicineBloc;

  const DailyMedicineType({Key key,@required this.dailyMedicineBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<String>(
      stream: dailyMedicineBloc.dailyMedicineType,
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
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (value){
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
      }
    );
  }
}
