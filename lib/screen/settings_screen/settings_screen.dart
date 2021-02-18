import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/settings_bloc/settings_bloc.dart';
import 'package:telemed_doc/screen/settings_screen/biometric_auth_switch.dart';
import 'package:telemed_doc/util/constant.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc settingsBloc = SettingsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
        backgroundColor: BG_BLUE2,
      ),
      backgroundColor: ALICE_BLUE,
      body: Stack(
        children: [
          Column(
            children: [
              BiometricAuthSwitch(settingsBloc: settingsBloc),
            ],
          ),
        ],
      ),
    );
  }
}
