import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telemed_doc/telemed_doc_app.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool authValue = await AppPreference.getBoolF(authStatusKey);
  debugPrint(authValue.toString());

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(TeleMedDocApp(
    authValue: authValue,
  ));
}
