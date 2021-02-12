import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';

class UserDetailDob extends StatelessWidget {
  final UserProfileDetailBloc userProfileDetailBloc;

  const UserDetailDob({Key key, @required this.userProfileDetailBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: userProfileDetailBloc.dob,
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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  //focusNode: fullNameFocusNode,
                  onChanged: (value) {
                    userProfileDetailBloc.changeDob(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Date of Birth(DD/MM/YYYY)',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
