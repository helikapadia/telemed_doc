import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextFormField(
            autocorrect: false,
            autofocus: true,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              fillColor: Colors.white,
              icon: Icon(Icons.search),
              hintText: 'Search for help',
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(25)
              //   ),
              //   borderSide: BorderSide(color: Colors.grey.shade100,width: 2),
              // ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

