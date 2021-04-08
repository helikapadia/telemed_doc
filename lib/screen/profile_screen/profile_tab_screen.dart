import 'package:flutter/material.dart';
import 'package:telemed_doc/screen/profile_screen/consulting_doctor_title.dart';
import 'package:telemed_doc/screen/profile_screen/daily_medicine_title.dart';
import 'package:telemed_doc/screen/profile_screen/emergency_detail_title.dart';
import 'package:telemed_doc/screen/profile_screen/family_member_title.dart';
import 'package:telemed_doc/screen/profile_screen/user_profile_title.dart';
import 'package:telemed_doc/util/constant.dart';

class ProfileTabScreen extends StatefulWidget {
  @override
  _ProfileTabScreenState createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
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
                    context, HOME_SCREEN, (route) => false);
              }),
        ),
      ),
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                UserProfileTitle(),
                const Divider(
                  color: Colors.grey,
                ),
                ConsultingDoctorTitle(),
                const Divider(
                  color: Colors.grey,
                ),
                EmergencyContactTitle(),
                const Divider(
                  color: Colors.grey,
                ),
                DailyMedicineTitle(),
                const Divider(
                  color: Colors.grey,
                ),
                FamilyMemberTitle(),
                const Divider(
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BG_BLUE2,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ADD_FAMILY);
        },
      ),
    );
  }
}
