import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DoctorDetailNumber extends StatelessWidget {
  final ConsultingDoctorDetailBloc consultingDoctorDetailBloc;

  const DoctorDetailNumber({Key key, @required this.consultingDoctorDetailBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: consultingDoctorDetailBloc.doctorPhoneNumber,
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
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  maxLength: 10,
                  //focusNode: fullNameFocusNode,
                  onChanged: (value) {
                    consultingDoctorDetailBloc.changeDoctorPhoneNumber(value);
                  },
                  validator: (value) {
                    if (value.length < 10) {
                      return PHONE_NUMBER_ERROR;
                    }
                  },
                  decoration: InputDecoration(
                    // suffixIcon: !snapshot.hasError &&
                    //         consultingDoctorDetailBloc.doctorPhoneNumberValue !=
                    //             null
                    //     ? Icon(
                    //         Icons.check,
                    //         color: Colors.green,
                    //       )
                    //     : null,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                  ),
                ),
              ),
            ),
          );
        });
  }
}
