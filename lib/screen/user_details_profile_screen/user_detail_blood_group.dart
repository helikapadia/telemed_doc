import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';

class UserDetailBloodGroup extends StatefulWidget {
  final UserProfileDetailBloc userProfileDetailBloc;

  const UserDetailBloodGroup({Key key, @required this.userProfileDetailBloc})
      : super(key: key);

  @override
  _UserDetailBloodGroupState createState() => _UserDetailBloodGroupState();
}

class _UserDetailBloodGroupState extends State<UserDetailBloodGroup> {
  int _value = 1;
  var currentValue;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.userProfileDetailBloc.bloodGroup,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            child: Card(
              elevation: 4,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DropdownButton<String>(
                    hint: Text('Please select your blood group'),
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
                      widget.userProfileDetailBloc.changeBloodGroup(value);
                      setState(() {
                        currentValue =
                            widget.userProfileDetailBloc.bloodGroupValue;
                      });
                    },
                  )),
            ),
          );
        });
  }
}
//TextFormField(
//                 autocorrect: false,
//                 autofocus: true,
//                 enableSuggestions: false,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 textAlign: TextAlign.start,
//                 //focusNode: fullNameFocusNode,
//                 onChanged: (value){
//                   userProfileDetailBloc.changeBloodGroup(value);
//                 },
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   border: InputBorder.none,
//                   hintText: 'Blood Group(i.e O+, A+, O-)',
//                 ),
//               ),
