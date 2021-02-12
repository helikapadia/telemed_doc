import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_bloc.dart';

class ProfileBloodGroup extends StatelessWidget {
  final ProfileBloc profileBloc;

  const ProfileBloodGroup({Key key,@required this.profileBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Icon(Icons.add_location_sharp),
          title: StreamBuilder<String>(
            stream: profileBloc.bloodGroup,
            builder: (context, snapshot){
              return Text(
                profileBloc.bloodGroupValue ?? "",style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              );
            },
          ),
        ),
      ),
    );
  }
}
