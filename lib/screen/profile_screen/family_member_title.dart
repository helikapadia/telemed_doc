import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class FamilyMemberTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Family Member',
        style: TextStyle(
            color: FONT_BLUE,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pushNamed(context, FAMILY_MEMBER_PROFILE_SCREEN);
      },
      trailing: IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed: () {
          Navigator.pushNamed(context, FAMILY_MEMBER_PROFILE_SCREEN);
        },
      ),
    );
  }
}
