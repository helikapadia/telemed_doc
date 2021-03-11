import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class ScannedDocumentFolderSelection extends StatelessWidget {
  var currentValue;
  String dropDownValue = 'Blood Report';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Card(
        color: ALICE_BLUE,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.only(right: 110),
          child: DropdownButton<String>(
            hint: Text('Select the Folder'),
            value: currentValue,
            items: [
              DropdownMenuItem(
                child: Text('Blood Report'),
                value: 'Blood Report',
              ),
              DropdownMenuItem(
                child: Text('X-Ray'),
                value: 'X-Ray',
              ),
              DropdownMenuItem(
                child: Text('CT Scan'),
                value: 'CT Scan',
              ),
              DropdownMenuItem(
                child: Text('Prescription'),
                value: 'Prescription',
              ),
              DropdownMenuItem(
                child: Text('Medical Policy'),
                value: 'Medical Policy',
              ),
            ],
            onChanged: (value) {
              // widget.dailyMedicineBloc.changeDailyMedicineType(value);
              // setState(() {
              //   currentValue =
              //       widget.dailyMedicineBloc.dailyMedicineTypeValue;
              // });
            },
          ),
        ),
      ),
    );
  }
}
