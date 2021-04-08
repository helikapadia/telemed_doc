import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class ConsultingDoctorTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Consulting Doctor',
        style: TextStyle(
            color: FONT_BLUE,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pushNamed(context, DOCTOR_DETAIL_PROFILE_SCREEN);
      },
      trailing: IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed: () {
          Navigator.pushNamed(context, DOCTOR_DETAIL_PROFILE_SCREEN);
        },
      ),
    );
  }
}
