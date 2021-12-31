// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:test/test.dart';
import 'package:intl_phone_field/phone_number.dart';

void main() {
  group('PhoneNumber', () {
    test('create a phone number', () {
      PhoneNumber phoneNumber = PhoneNumber(
          countryISOCode: "UK", countryCode: "+44", number: "7891234567");
      String actual = phoneNumber.completeNumber;
      String expected = "+447891234567";

      expect(actual, expected);
    });

    test('create a Guernsey number', () {
      PhoneNumber phoneNumber = PhoneNumber(
          countryISOCode: "UK", countryCode: "+44", number: "1481960194");
      String actual = phoneNumber.completeNumber;
      String expected = "+441481960194";

      expect(actual, expected);
    });

    test('look up UK as a country code', () {
      Country country = PhoneNumber.getCountry("+447891234567");
      expect(country.name, "United Kingdom");
      expect(country.code, "GB");
      expect(country.regionCode, "");
    });

    test('look up Guernsey as a country code', () {
      Country country = PhoneNumber.getCountry("+441481960194");
      expect(country.name, "Guernsey");
      expect(country.code, "GG");
      expect(country.regionCode, "1481");
    });

    test('create HK  number +85212345678', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+85212345678");
      expect(phoneNumber.countryISOCode, "HK");
      expect(phoneNumber.countryCode, "852");
      expect(phoneNumber.number, "12345678");
    });

    test('cannot create from too short number +8521234567', () {
      expect(
          () => PhoneNumber.fromCompleteNumber(completeNumber: "+8521234567"),
          throwsA(TypeMatcher<NumberTooShortException>()));
    });

    test('cannot create from too long number +852123456789', () {
      expect(
          () => PhoneNumber.fromCompleteNumber(completeNumber: "+852123456789"),
          throwsA(TypeMatcher<NumberTooLongException>()));
    });

    test('create UK PhoneNumber from +447891234567', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+447891234567");
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryCode, "44");
      expect(phoneNumber.number, "7891234567");
    });

    test('create Guernsey PhoneNumber from +441481960194', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+441481960194");
      expect(phoneNumber.countryISOCode, "GG");
      expect(phoneNumber.countryCode, "441481");
      expect(phoneNumber.number, "960194");
    });
  });
}
