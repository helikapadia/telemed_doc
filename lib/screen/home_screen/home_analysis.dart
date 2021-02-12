import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeAnalysis extends StatefulWidget {
  @override
  _HomeAnalysisState createState() => _HomeAnalysisState();
}

class _HomeAnalysisState extends State<HomeAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          FlatButton(
              onPressed: (){},
              child: Text('Analysis Reports', style: TextStyle(fontFamily: 'Poppins', color: FONT_BLUE, fontSize: 14),),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('images/Analysis Data.png', height: 178, width: 153,),
            ],
          )
        ],
      ),
    );
  }
}
