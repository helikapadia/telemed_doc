import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_bloc.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter_down.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_address.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_design.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_name.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_number.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_specialization.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_detail_submit_btn.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class DoctorDetails extends StatefulWidget {
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  ConsultingDoctorDetailBloc consultingDoctorDetailBloc = ConsultingDoctorDetailBloc();

  @override
  void dispose(){
    consultingDoctorDetailBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: ALICE_BLUE,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DoctorDetailDesign(),
                  DoctorDetailName(consultingDoctorDetailBloc: consultingDoctorDetailBloc,),
                  DoctorDetailNumber(consultingDoctorDetailBloc: consultingDoctorDetailBloc,),
                  DoctorDetailAddress(consultingDoctorDetailBloc: consultingDoctorDetailBloc,),
                  DoctorDetailSpecialization(consultingDoctorDetailBloc: consultingDoctorDetailBloc,),
                  const SizedBox(
                    height: 10,
                  ),
                  DoctorDetailSubmitBtn(consultingDoctorDetailBloc: consultingDoctorDetailBloc,),
                  const SizedBox(
                    height: 5,
                  ),
                  CurvePainterDown(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
