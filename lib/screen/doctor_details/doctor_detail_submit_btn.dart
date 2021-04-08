import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class DoctorDetailSubmitBtn extends StatelessWidget {
  final ConsultingDoctorDetailBloc consultingDoctorDetailBloc;

  const DoctorDetailSubmitBtn(
      {Key key, @required this.consultingDoctorDetailBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: consultingDoctorDetailBloc.submitDoctorDetails,
        builder: (context, snapshot) {
          bool isEnabled = snapshot.data ?? false;
          return TextButton(
              onPressed: isEnabled
                  ? () {
                      consultingDoctorDetailBloc.addDoctorDetails(context);
                    }
                  : null,
              child: Container(
                width: MediaQuery.of(context).size.width - 65,
                height: 50,
                //padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  color: isEnabled ? BUTTON_BLUE : Colors.grey,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ));
        });
  }
}
