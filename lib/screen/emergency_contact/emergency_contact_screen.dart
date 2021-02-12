import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/emergency_bloc/emergency_bloc.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter_down.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_contact_number.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_email.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_medical.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_screen_design.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_submit.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class EmergencyContactScreen extends StatefulWidget {
  @override
  _EmergencyContactScreenState createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  EmergencyBloc emergencyBloc =EmergencyBloc();
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
                  EmergencyScreenDesign(),
                  const SizedBox(
                    height: 15,
                  ),
                  EmergencyMedical(),
                  EmergencyEmail(emergencyBloc: emergencyBloc,),
                  EmergencyContactNumber(emergencyBloc: emergencyBloc,),
                  const SizedBox(
                    height: 10,
                  ),
                  EmergencySubmit(emergencyBloc: emergencyBloc,),
                  const SizedBox(
                    height: 5,
                  ),
                  CurvePainterDown(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
