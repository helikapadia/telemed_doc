import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class AddFamilySubmitBtn extends StatelessWidget {
  final AddFamilyBloc addFamilyBloc;

  const AddFamilySubmitBtn({Key key, this.addFamilyBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: addFamilyBloc.submitCheck,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;
          return TextButton(
              onPressed: isEnabled
                  ? () {
                      addFamilyBloc.addFamilyDetails(context);
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
