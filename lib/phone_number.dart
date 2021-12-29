import 'package:flutter/material.dart';

import 'countries.dart';

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  factory PhoneNumber.fromCompleteNumber({required String completeNumber}){
    Country country = getCountry(completeNumber);
    String number;
    if (completeNumber.startsWith('+')) {
      number = completeNumber.substring(1+country.dialCode.length+country.regionCode.length);
    } else {
      number = completeNumber.substring(country.dialCode.length+country.regionCode.length);
    }
    return PhoneNumber(countryISOCode: country.code,
        countryCode: country.dialCode + country.regionCode,
        number: number);
  }

  String get completeNumber {
    return countryCode + number;
  }

  static Country getCountry(String phoneNumber) {
    if (phoneNumber.startsWith('+')) {
      return countries.firstWhere((country) =>
          phoneNumber
              .substring(1)
              .startsWith(country.dialCode + country.regionCode));
    }
    return countries.firstWhere((country) =>
        phoneNumber.startsWith(country.dialCode + country.regionCode));
  }
}
