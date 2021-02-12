import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_city_bloc/add_city_bloc.dart';
import 'package:telemed_doc/screen/add_city/add_city_submit.dart';
import 'package:telemed_doc/screen/add_city/add_location.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class AddCity extends StatefulWidget {
  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {

  AddCityBloc addCityBloc = AddCityBloc();
  @override
  void dispose(){
    addCityBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: Image.asset(
                        'images/Logo.png',
                        height: 50,
                      )),
                  Text(
                    'TeleMed Doc',
                    style: TextStyle(
                        color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Locate your City',
                    style: TextStyle(
                        color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Image.asset(
                        'images/location icon.png',
                        height: 50,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Center(
                      child: Text(
                        'Choose your city so we can offer',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Center(
                      child: Text(
                        'the service that suit you',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AddLocation(addCityBloc: addCityBloc,),
                  const SizedBox(
                    height: 30,
                  ),
                  AddCitySubmit(addCityBloc: addCityBloc,),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
