import 'countries.dart';

class NumberTooLongException implements Exception {}

class NumberTooShortException implements Exception {}

class InvalidCharactersException implements Exception {}

class LocalPhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  LocalPhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  factory LocalPhoneNumber.fromCompleteNumber({required String completeNumber}) {
    if (completeNumber == "") {
      return LocalPhoneNumber(countryISOCode: "", countryCode: "", number: "");
    }

    try {
      Country country = getCountry(completeNumber);
      String number;
      if (completeNumber.startsWith('+')) {
        number = completeNumber.substring(1 + country.dialCode.length + country.regionCode.length);
      } else {
        number = completeNumber.substring(country.dialCode.length + country.regionCode.length);
      }
      return LocalPhoneNumber(
          countryISOCode: country.code, countryCode: country.dialCode + country.regionCode, number: number);
    } on InvalidCharactersException {
      rethrow;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      return LocalPhoneNumber(countryISOCode: "", countryCode: "", number: "");
    }
  }

  bool isValidNumber() {
    Country country = getCountry(completeNumber);
    if (number.length < country.minLength) {
      throw NumberTooShortException();
    }

    if (number.length > country.maxLength) {
      throw NumberTooLongException();
    }
    return true;
  }

  String get completeNumber {
    return countryCode + number;
  }

  static Country getCountry(String localPhoneNumber) {
    if (localPhoneNumber == "") {
      throw NumberTooShortException();
    }

    final validLocalPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validLocalPhoneNumber.hasMatch(localPhoneNumber)) {
      throw InvalidCharactersException();
    }

    if (localPhoneNumber.startsWith('+')) {
      return countries
          .firstWhere((country) => localPhoneNumber.substring(1).startsWith(country.dialCode + country.regionCode));
    }
    return countries.firstWhere((country) => localPhoneNumber.startsWith(country.dialCode + country.regionCode));
  }

  @override
  String toString() => 'LocalPhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
