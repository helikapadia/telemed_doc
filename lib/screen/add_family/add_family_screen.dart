import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter_down.dart';
import 'package:telemed_doc/screen/add_family/add_family_allergies.dart';
import 'package:telemed_doc/screen/add_family/add_family_blood_group.dart';
import 'package:telemed_doc/screen/add_family/add_family_dob.dart';
import 'package:telemed_doc/screen/add_family/add_family_fam_history.dart';
import 'package:telemed_doc/screen/add_family/add_family_gender.dart';
import 'package:telemed_doc/screen/add_family/add_family_name.dart';
import 'package:telemed_doc/screen/add_family/add_family_screen_design.dart';
import 'package:telemed_doc/screen/add_family/add_family_submit_btn.dart';
import 'package:telemed_doc/screen/add_family/add_family_troubles.dart';
import 'package:telemed_doc/util/constant.dart';

class AddFamilyScreen extends StatefulWidget {
  @override
  _AddFamilyScreenState createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends State<AddFamilyScreen> {
  AddFamilyBloc addFamilyBloc = AddFamilyBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BG_BLUE2,
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PROFILE_TAB_SCREEN, (route) => false);
                }),
          ),
        ),
        backgroundColor: ALICE_BLUE,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AddFamilyScreenDesign(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please fill the details to",
                        style: TextStyle(
                            color: FONT_BLUE,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                      Text(
                        "add your family member.",
                        style: TextStyle(
                            color: FONT_BLUE,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                    ],
                  ),
                  AddFamilyName(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyGender(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyDOB(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyBloodGroup(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyAllergies(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyTroubles(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  AddFamilyFamHistory(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddFamilySubmitBtn(
                    addFamilyBloc: addFamilyBloc,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CurvePainterDown(),
                ],
              ),
            )
          ],
        ));
  }
}
