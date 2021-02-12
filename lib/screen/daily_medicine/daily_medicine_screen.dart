import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/daily_medicine_bloc/daily_medicine_detail_bloc.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_design.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_dosage.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_name.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_number.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_submit.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_type.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/constant.dart';

class DailyMedicineScreen extends StatefulWidget {
  @override
  _DailyMedicineScreenState createState() => _DailyMedicineScreenState();
}

class _DailyMedicineScreenState extends State<DailyMedicineScreen> {
  DailyMedicineBloc dailyMedicineBloc = DailyMedicineBloc();
  @override
  void dispose() {
    dailyMedicineBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  DailyMedicineDesign(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'images/Illustrator_Medicine.png',
                            height: 150,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50, top: 10),
                            child: Text(
                              'Numbers of Medicine',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: FONT_BLUE,
                                  fontSize: 20),
                            ),
                          ),
                          DailyMedicineNumber(
                            dailyMedicineBloc: dailyMedicineBloc,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 110, top: 10),
                            child: Text(
                              'Medicine Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: FONT_BLUE,
                                  fontSize: 20),
                            ),
                          ),
                          DailyMedicineName(
                            dailyMedicineBloc: dailyMedicineBloc,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 120, top: 10),
                            child: Text(
                              'Medicine Type',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: FONT_BLUE,
                                  fontSize: 20),
                            ),
                          ),
                          DailyMedicineType(
                            dailyMedicineBloc: dailyMedicineBloc,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 190, top: 10),
                            child: Text(
                              'Dosage',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: FONT_BLUE,
                                  fontSize: 20),
                            ),
                          ),
                          DailyMedicineDosage(
                            dailyMedicineBloc: dailyMedicineBloc,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DailyMedicineSubmitBtn(
                    dailyMedicineBloc: dailyMedicineBloc,
                  ),
                  const SizedBox(
                    height: 50,
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
