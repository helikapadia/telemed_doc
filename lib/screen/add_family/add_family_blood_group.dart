import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';

class AddFamilyBloodGroup extends StatefulWidget {
  final AddFamilyBloc addFamilyBloc;

  const AddFamilyBloodGroup({Key key, this.addFamilyBloc}) : super(key: key);
  @override
  _AddFamilyBloodGroupState createState() => _AddFamilyBloodGroupState();
}

class _AddFamilyBloodGroupState extends State<AddFamilyBloodGroup> {
  int _value = 1;
  var currentValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Card(
        elevation: 4,
        child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButton<String>(
              hint: Text('Please select the blood group'),
              value: currentValue,
              items: [
                DropdownMenuItem(
                  child: Text('A+'),
                  value: 'A+',
                ),
                DropdownMenuItem(
                  child: Text('B+'),
                  value: 'B+',
                ),
                DropdownMenuItem(
                  child: Text('AB+'),
                  value: 'AB+',
                ),
                DropdownMenuItem(
                  child: Text('O+'),
                  value: 'O+',
                ),
                DropdownMenuItem(
                  child: Text('A-'),
                  value: 'A-',
                ),
                DropdownMenuItem(
                  child: Text('B-'),
                  value: 'B-',
                ),
                DropdownMenuItem(
                  child: Text('AB-'),
                  value: 'AB-',
                ),
                DropdownMenuItem(
                  child: Text('O-'),
                  value: 'O-',
                ),
              ],
              onChanged: (value) {
                widget.addFamilyBloc.changeBloodGroup(value);
                setState(() {
                  currentValue = widget.addFamilyBloc.bloodGroupValue;
                });
              },
            )),
      ),
    );
  }
}
