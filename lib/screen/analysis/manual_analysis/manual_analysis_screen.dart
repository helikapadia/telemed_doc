import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/manual_analysis_bloc/manual_analysis_bloc.dart';
import 'package:telemed_doc/screen/analysis/manual_analysis/blood_pressure/blood_pressure_dia.dart';
import 'package:telemed_doc/screen/analysis/manual_analysis/blood_pressure/blood_pressure_sys.dart';
import 'package:telemed_doc/screen/analysis/manual_analysis/blood_sugar/blood_sugar_before_meal.dart';
import 'package:telemed_doc/screen/analysis/manual_analysis/blood_sugar/blood_sugar_fasting.dart';
import 'package:telemed_doc/screen/analysis/manual_analysis/manual_analysis_submit_btn.dart';
import 'package:telemed_doc/util/constant.dart';

class ManualAnalysisScreen extends StatefulWidget {
  @override
  _ManualAnalysisScreenState createState() => _ManualAnalysisScreenState();
}

class _ManualAnalysisScreenState extends State<ManualAnalysisScreen> {
  ManualAnalysisBloc manualAnalysisBloc = ManualAnalysisBloc();
  @override
  void dispose() {
    manualAnalysisBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Analysis Details'),
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
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Blood Pressure',
                                style: TextStyle(
                                  color: FONT_BLUE,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 180, top: 10),
                                child: Text(
                                  'Systolic: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: FONT_BLUE,
                                      fontSize: 20),
                                ),
                              ),
                              BloodPressureSys(
                                manualAnalysisBloc: manualAnalysisBloc,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 170, top: 10),
                                child: Text(
                                  'Diastolic: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: FONT_BLUE,
                                      fontSize: 20),
                                ),
                              ),
                              BloodPressureDia(
                                  manualAnalysisBloc: manualAnalysisBloc),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Blood Sugar',
                                style: TextStyle(
                                  color: FONT_BLUE,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 110, top: 10),
                                child: Text(
                                  'Fasting Sugar: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: FONT_BLUE,
                                      fontSize: 20),
                                ),
                              ),
                              BloodSugarFasting(
                                  manualAnalysisBloc: manualAnalysisBloc),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 60, top: 10),
                                child: Text(
                                  'Before Meal Sugar: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: FONT_BLUE,
                                      fontSize: 20),
                                ),
                              ),
                              BloodSugarBeforeMeal(
                                  manualAnalysisBloc: manualAnalysisBloc),
                            ],
                          ),
                        ),
                      ),
                      ManualAnalysisSubmitButton(
                          manualAnalysisBloc: manualAnalysisBloc),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
