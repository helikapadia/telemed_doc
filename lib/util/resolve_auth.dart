import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/screen/home_screen/home_screen.dart';
import 'package:telemed_doc/screen/login/login_screen.dart';
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
    var user = FirebaseAuth.instance.currentUser.uid;
    AppPreference.getStringF(user).then((userId) {
      debugPrint(user);
      if (user != null) {
        if (CITY_KEY == null) {
          return MaterialPageRoute(builder: (context) {
            return LoginScreen();
          });
        } else {
          return MaterialPageRoute(builder: (context) {
            return HomeScreen();
          });
        }
      } else {
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
