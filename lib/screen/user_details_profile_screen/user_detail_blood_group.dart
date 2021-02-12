import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';

class UserDetailBloodGroup extends StatelessWidget {
  final UserProfileDetailBloc userProfileDetailBloc;

  const UserDetailBloodGroup({Key key,@required this.userProfileDetailBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: userProfileDetailBloc.bloodGroup,
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
                onChanged: (value){
                  userProfileDetailBloc.changeBloodGroup(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Blood Group(i.e O+, A+, O-)',
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
