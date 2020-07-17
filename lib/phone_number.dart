import 'package:flutter/foundation.dart';

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    @required this.countryISOCode,
    @required this.countryCode,
    @required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }
}
