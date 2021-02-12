import 'package:flutter/material.dart';

class CountryCode {
  const CountryCode(
      {@required this.name,
        @required this.flagUri,
        @required this.code,
        @required this.dialCode});

  final String name;
  final String flagUri;
  final String code;
  final String dialCode;

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode $name";

  String toCountryStringOnly() => '$name';
}