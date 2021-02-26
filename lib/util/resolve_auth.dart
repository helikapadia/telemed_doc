import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class ResolveAuth extends StatefulWidget {
  @override
  _ResolveAuthState createState() => _ResolveAuthState();
}

class _ResolveAuthState extends State<ResolveAuth> {
  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      AppPreference.getStringF(USER_ID_KEY).then((value) async {
        if (CITY_KEY != null) {
          bool authValue = await AppPreference.getBoolF(authStatusKey);
          debugPrint(authValue.toString());
          if (authValue != null && authValue) {
            Navigator.pushNamedAndRemoveUntil(
                context, BIOMETRIC_AUTH, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, HOME_SCREEN, (route) => false);
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LOGIN_ROUTE, (route) => false);
        }
      }).catchError((error) {
        Navigator.pushNamedAndRemoveUntil(
            context, LOGIN_ROUTE, (route) => false);
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
