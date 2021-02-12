import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_bloc.dart';

class DoctorDetailSpecialization extends StatelessWidget {
  final ConsultingDoctorDetailBloc consultingDoctorDetailBloc;

  const DoctorDetailSpecialization({Key key,@required this.consultingDoctorDetailBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: consultingDoctorDetailBloc.doctorSpecialization,
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
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                //focusNode: fullNameFocusNode,
                onChanged: (value){
                  consultingDoctorDetailBloc.changeDoctorSpecialization(value);
                },
                decoration: InputDecoration(
                  suffixIcon: !snapshot.hasError &&
                      consultingDoctorDetailBloc.doctorSpecializationValue != null
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                      : null,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Specialization',
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
