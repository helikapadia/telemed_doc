import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/emergency_bloc/emergency_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class EmergencyContactNumber extends StatelessWidget {
  final EmergencyBloc emergencyBloc;

  const EmergencyContactNumber({Key key, @required this.emergencyBloc})
      : super(key: key);

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
                  maxLength: 10,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    emergencyBloc.phoneNumberChanged(value);
                  },
                  validator: (value) {
                    if (value.length < 10) {
                      return PHONE_NUMBER_ERROR;
                    }
                  },
                  decoration: InputDecoration(
                    // suffixIcon: !snapshot.hasError &&
                    //         emergencyBloc.phoneNumberValue != null
                    //     ? Icon(
                    //         Icons.check,
                    //         color: Colors.green,
                    //       )
                    //     : null,
                    fillColor: Colors.white,
                    hintText: '(71) 555-555',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
