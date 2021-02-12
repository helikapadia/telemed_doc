import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class LoginRememberMe extends StatelessWidget {
  bool _isRembemerMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              // ignore: missing_required_param
              child: Checkbox(
                checkColor: Colors.blue,
                activeColor: Colors.white,
                value: _isRembemerMe,
                //onChanged: handleRememberMe,
              ),
            ),
            Text(
              "Remember me",
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FORGOT_PASSWORD_ROUTE);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.blueGrey, fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
