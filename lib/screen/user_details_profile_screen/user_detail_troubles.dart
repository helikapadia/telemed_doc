import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';

class UserDetailTrouble extends StatelessWidget {
  final UserProfileDetailBloc userProfileDetailBloc;

  const UserDetailTrouble({Key key, @required this.userProfileDetailBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: userProfileDetailBloc.trouble,
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
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  //focusNode: fullNameFocusNode,
                  onChanged: (value) {
                    userProfileDetailBloc.changeTrouble(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: !snapshot.hasError &&
                            userProfileDetailBloc.troubleValue != null
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Troubles',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
