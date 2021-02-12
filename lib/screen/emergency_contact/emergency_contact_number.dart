import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/emergency_bloc/emergency_bloc.dart';

class EmergencyContactNumber extends StatelessWidget {
  final EmergencyBloc emergencyBloc;

  const EmergencyContactNumber({Key key,@required this.emergencyBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: emergencyBloc.phoneNumber,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                autocorrect: false,
                autofocus: true,
                enableSuggestions: false,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                onChanged: (value){
                  emergencyBloc.phoneNumberChanged(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: '(71) 555-555',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
