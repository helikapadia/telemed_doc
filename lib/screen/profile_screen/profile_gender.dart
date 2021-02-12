import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_bloc.dart';

class ProfileGender extends StatelessWidget {
  final ProfileBloc profileBloc;

  const ProfileGender({Key key,@required this.profileBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Icon(Icons.fiber_manual_record_outlined),
          title: StreamBuilder<String>(
            stream: profileBloc.gender,
            builder: (context, snapshot){
              return Text(
                profileBloc.genderValue ?? "", style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              );
            },
          ),
        ),
      ),
    );
  }
}
