import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/settings_bloc/settings_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class BiometricAuthSwitch extends StatelessWidget {
  final SettingsBloc settingsBloc;

  const BiometricAuthSwitch({Key key, @required this.settingsBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Biometric Authentication',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
        ),
      ),
      trailing: StreamBuilder<bool>(
        stream: settingsBloc.authOn,
        builder: (context, snapshot) {
          return CupertinoSwitch(
            value: settingsBloc?.authOnValue ?? false,
            onChanged: (value) {
              debugPrint("auth value : " + value.toString());
              settingsBloc.updateAuthOn(context, value);
            },
            activeColor:
                settingsBloc?.authOnValue ?? false ? BLUE : Colors.grey,
          );
        },
      ),
    );
  }
}
