import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_bloc.dart';

class ProfileDOB extends StatelessWidget {
  final ProfileBloc profileBloc;

  const ProfileDOB({Key key,@required this.profileBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Icon(Icons.date_range),
          title: StreamBuilder<String>(
            stream: profileBloc.dob,
            builder: (context, snapshot){
              return Text(
                profileBloc.dobValue ?? "", style: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.black),
              );
            },
          ),
        ),
      ),
    );
  }
}
