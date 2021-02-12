import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_city_bloc/add_city_bloc.dart';

class AddLocation extends StatelessWidget {
  final AddCityBloc addCityBloc;

  const AddLocation({Key key,@required this.addCityBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: addCityBloc.addCity,
      builder: (context, snapshot) {
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
                onChanged: (value){
                  addCityBloc?.changeAddCity(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  icon: Icon(Icons.location_on),
                  hintText: 'Your Location',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
