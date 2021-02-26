import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/daily_medicine_bloc/daily_medicine_detail_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineType extends StatefulWidget {
  final DailyMedicineBloc dailyMedicineBloc;

  const DailyMedicineType({Key key, @required this.dailyMedicineBloc})
      : super(key: key);
  @override
  _DailyMedicineTypeState createState() => _DailyMedicineTypeState();
}

class _DailyMedicineTypeState extends State<DailyMedicineType> {
  var currentValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.dailyMedicineBloc.dailyMedicineType,
        builder: (context, snapshot) {
          String dropDownValue = 'Drops';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              color: ALICE_BLUE,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButton<String>(
                  hint: Text('Please select Medicine Type'),
                  value: currentValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('Drops'),
                      value: 'Drops',
                    ),
                    DropdownMenuItem(
                      child: Text('Liquids'),
                      value: 'Liquids',
                    ),
                    DropdownMenuItem(
                      child: Text('Capsules'),
                      value: 'Capsules',
                    ),
                    DropdownMenuItem(
                      child: Text('Tablets'),
                      value: 'Tablets',
                    ),
                  ],
                  onChanged: (value) {
                    widget.dailyMedicineBloc.changeDailyMedicineType(value);
                    setState(() {
                      currentValue =
                          widget.dailyMedicineBloc.dailyMedicineTypeValue;
                    });
                  },
                ),
              ),
            ),
          );
        });
  }
}
//TextFormField(
//                   autocorrect: false,
//                   autofocus: true,
//                   enableSuggestions: false,
//                   keyboardType: TextInputType.text,
//                   textInputAction: TextInputAction.next,
//                   textAlign: TextAlign.start,
//                   onChanged: (value) {
//                     dailyMedicineBloc.changeDailyMedicineType(value);
//                   },
//                   decoration: InputDecoration(
//                     suffixIcon: !snapshot.hasError &&
//                             dailyMedicineBloc.dailyMedicineTypeValue != null
//                         ? Icon(
//                             Icons.check,
//                             color: Colors.green,
//                           )
//                         : null,
//                     border: InputBorder.none,
//                     fillColor: ALICE_BLUE,
//                     hintText: 'Type of Medicine',
//                   ),
//                 ),
