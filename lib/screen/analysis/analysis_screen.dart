import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/manual_analysis_bloc/manual_analysis_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  ManualAnalysisBloc manualAnalysisBloc = ManualAnalysisBloc();
  var userIdVal = FirebaseAuth.instance.currentUser.uid;

  @override
  void initState() {
    debugPrint("123");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user/$userIdVal/manual_data_analysis/")
            .orderBy("analysis_date", descending: false)
            .snapshots(),
        //bpSys = snapshot.data.docs["blood_pressure_sys"];
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:

            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.active:

            case ConnectionState.done:
              final List<QueryDocumentSnapshot> query = snapshot.data.docs;
              List<FlSpot> spots1 = [];
              List<FlSpot> spots2 = [];
              List<FlSpot> spots3 = [];
              List<FlSpot> spots4 = [];
              query.forEach((value) {
                print(value.data()['blood_pressure_sys']);
                spots1.add(FlSpot(
                  value.data()['analysis_date'].toDate().month.toDouble(),
                  double.parse(value.data()['blood_pressure_sys']),
                ));
                debugPrint(value.get('blood_pressure_dia'));
                spots2.add(FlSpot(
                  value.data()['analysis_date'].toDate().month.toDouble(),
                  double.parse(value.data()['blood_pressure_dia']),
                ));
                spots3.add(FlSpot(
                  value.data()['analysis_date'].toDate().month.toDouble(),
                  double.parse(value.data()['blood_sugar_fast']),
                ));
                spots4.add(FlSpot(
                  value.data()['analysis_date'].toDate().month.toDouble(),
                  double.parse(value.data()['blood_sugar_before']),
                ));
              });

              return Scaffold(
                appBar: AppBar(
                  title: Text('Analysis'),
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
                backgroundColor: Colors.black,
                body: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        colors: [Color(0xff434343), Color(0xff000000)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 37,
                          ),
                          const Text(
                            'Medical Analysis',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 37,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 16.0, left: 6.0),
                              child: LineChart(
                                sampleData1(
                                    spots: spots1,
                                    spots2: spots2,
                                    spots3: spots3,
                                    spots4: spots4),
                                swapAnimationDuration:
                                    const Duration(milliseconds: 250),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        });
  }

  LineChartData sampleData1(
      {List<FlSpot> spots,
      List<FlSpot> spots2,
      List<FlSpot> spots3,
      List<FlSpot> spots4}) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          rotateAngle: 45,
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            print(value);
            print(value.runtimeType);
            switch (value.toInt()) {
              case 1:
                return 'JAN';
              case 2:
                return 'FEB';
              case 3:
                return 'MAR';
              case 4:
                return 'APR';
              case 5:
                return 'MAY';
              case 6:
                return 'JUNE';
              case 7:
                return 'JULY';
              case 8:
                return 'AUG';
              case 9:
                return 'SEP';
              case 10:
                return 'OCT';
              case 11:
                return 'NOV';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return value.toString();
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 13,
      maxY: 200,
      minY: 0,
      lineBarsData: linesBarData1(
          spots: spots, spots2: spots2, spots3: spots3, spots4: spots4),
    );
  }

  List<LineChartBarData> linesBarData1(
      {List<FlSpot> spots,
      List<FlSpot> spots2,
      List<FlSpot> spots3,
      List<FlSpot> spots4}) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: spots2,
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: spots3,
      isCurved: true,
      colors: [
        const Color(0xffaa4634),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    final LineChartBarData lineChartBarData4 = LineChartBarData(
      spots: spots4,
      isCurved: true,
      colors: [
        const Color(0xffaa3456),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
      lineChartBarData4,
    ];
  }
}
