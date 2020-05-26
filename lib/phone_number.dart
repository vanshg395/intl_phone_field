import 'package:flutter/foundation.dart';

class PhoneNumber {
  String countryCode;
  String number;

  PhoneNumber({
    @required this.countryCode,
    @required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }
}
