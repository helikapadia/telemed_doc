import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';

class AddFamilyName extends StatelessWidget {
  final AddFamilyBloc addFamilyBloc;

  const AddFamilyName({Key key, this.addFamilyBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: addFamilyBloc.fullName,
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  //focusNode: fullNameFocusNode,
                  onChanged: (value) {
                    addFamilyBloc.fullNameChanged(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Full Name',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
