import 'package:flutter/foundation.dart';
import 'package:intl_phone_field/country.dart';

class PhoneNumber {
  Country country;
  String number;

  PhoneNumber({
    @required this.country,
    @required this.number,
  });

  String get completeNumber {
    return country.dialCode + number;
  }

  @override
  String toString() => "PhoneNumber($completeNumber)";
}
