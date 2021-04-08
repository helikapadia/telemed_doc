import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/user_profile_detail_bloc/user_profile_detail_bloc.dart';
import 'package:telemed_doc/component/curve_painter/curve_painter_down.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_age.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_allergies.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_blood_group.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_dob.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_family_history.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_phone_number.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_submit_btn.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_detail_troubles.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_details_design.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class UserDetailsProfileScreen extends StatefulWidget {
  @override
  _UserDetailsProfileScreenState createState() =>
      _UserDetailsProfileScreenState();
}

class _UserDetailsProfileScreenState extends State<UserDetailsProfileScreen> {
  UserProfileDetailBloc userProfileDetailBloc = UserProfileDetailBloc();
  @override
  void dispose() {
    userProfileDetailBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  UserDetailsDesign(),
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
                        "complete your profile.",
                        style: TextStyle(
                            color: FONT_BLUE,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                    ],
                  ),
                  // UserDetailFullName(
                  //   userProfileDetailBloc: userProfileDetailBloc,
                  // ),
                  UserDetailAge(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  // UserDetailGender(
                  //   userProfileDetailBloc: userProfileDetailBloc,
                  // ),
                  // UserDetailEmail(
                  //   userProfileDetailBloc: userProfileDetailBloc,
                  // ),
                  UserDetailPhoneNumber(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  UserDetailDob(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  UserDetailBloodGroup(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  UserDetailAllergies(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  UserDetailTrouble(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  UserDetailFamilyHistory(
                      userProfileDetailBloc: userProfileDetailBloc),
                  const SizedBox(
                    height: 10,
                  ),
                  UserDetailSubmitBtn(
                    userProfileDetailBloc: userProfileDetailBloc,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Want to add family members',
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'details?',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Family Details',
                              style: TextStyle(color: BLUE),
                            ),
                          ],
                        ),
                      ],
                    ),
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
