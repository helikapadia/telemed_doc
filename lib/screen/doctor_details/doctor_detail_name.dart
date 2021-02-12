import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_bloc.dart';

class DoctorDetailName extends StatelessWidget {
  final ConsultingDoctorDetailBloc consultingDoctorDetailBloc;

  const DoctorDetailName({Key key,@required this.consultingDoctorDetailBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: consultingDoctorDetailBloc.doctorFullName,
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
                onChanged: (value){
                  consultingDoctorDetailBloc.changeDoctorFullName(value);
                },
                decoration: InputDecoration(
                  suffixIcon: !snapshot.hasError &&
                      consultingDoctorDetailBloc.doctorFullNameValue != null
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                      : null,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Full Name',
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
