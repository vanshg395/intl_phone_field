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
  group('LocalPhoneNumber', () {
    test('create a phone number', () {
      LocalPhoneNumber localPhoneNumber =
          LocalPhoneNumber(countryISOCode: "UK", countryCode: "+44", number: "7891234567");
      String actual = localPhoneNumber.completeNumber;
      String expected = "+447891234567";

      expect(actual, expected);
      expect(localPhoneNumber.isValidNumber(), true);
    });

    test('create a Guernsey number', () {
      LocalPhoneNumber localPhoneNumber =
          LocalPhoneNumber(countryISOCode: "GG", countryCode: "+441481", number: "960194");
      String actual = localPhoneNumber.completeNumber;
      String expected = "+441481960194";

      expect(actual, expected);
      expect(localPhoneNumber.isValidNumber(), true);
    });

    test('look up UK as a country code', () {
      Country country = LocalPhoneNumber.getCountry("+447891234567");
      expect(country.name, "United Kingdom");
      expect(country.code, "GB");
      expect(country.regionCode, "");
    });

    test('look up Guernsey as a country code', () {
      Country country = LocalPhoneNumber.getCountry("+441481960194");
      expect(country.name, "Guernsey");
      expect(country.code, "GG");
      expect(country.regionCode, "1481");
    });

    test('create with empty complete number', () {
      LocalPhoneNumber localPhoneNumber = LocalPhoneNumber.fromCompleteNumber(completeNumber: "");
      expect(localPhoneNumber.countryISOCode, "");
      expect(localPhoneNumber.countryCode, "");
      expect(localPhoneNumber.number, "");
      expect(() => localPhoneNumber.isValidNumber(), throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('create HK  number +85212345678', () {
      LocalPhoneNumber localPhoneNumber = LocalPhoneNumber.fromCompleteNumber(completeNumber: "+85212345678");
      expect(localPhoneNumber.countryISOCode, "HK");
      expect(localPhoneNumber.countryCode, "852");
      expect(localPhoneNumber.number, "12345678");
      expect(localPhoneNumber.isValidNumber(), true);
    });

    test('Number is too short number +8521234567', () {
      LocalPhoneNumber ph = LocalPhoneNumber.fromCompleteNumber(completeNumber: "+8521234567");
      expect(() => ph.isValidNumber(), throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('cannot create from too long number +852123456789', () {
      LocalPhoneNumber ph = LocalPhoneNumber.fromCompleteNumber(completeNumber: "+852123456789");

      expect(() => ph.isValidNumber(), throwsA(const TypeMatcher<NumberTooLongException>()));
    });

    test('create UK LocalPhoneNumber from +447891234567', () {
      LocalPhoneNumber localPhoneNumber = LocalPhoneNumber.fromCompleteNumber(completeNumber: "+447891234567");
      expect(localPhoneNumber.countryISOCode, "GB");
      expect(localPhoneNumber.countryCode, "44");
      expect(localPhoneNumber.number, "7891234567");
      expect(localPhoneNumber.isValidNumber(), true);
    });

    test('create Guernsey LocalPhoneNumber from +441481960194', () {
      LocalPhoneNumber localPhoneNumber = LocalPhoneNumber.fromCompleteNumber(completeNumber: "+441481960194");
      expect(localPhoneNumber.countryISOCode, "GG");
      expect(localPhoneNumber.countryCode, "441481");
      expect(localPhoneNumber.number, "960194");
      expect(localPhoneNumber.isValidNumber(), true);
    });

    test('create alpha character in  LocalPhoneNumber from +44abcdef', () {
      expect(() => LocalPhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });

    test('create alpha character in  LocalPhoneNumber from +44abcdef1', () {
      expect(() => LocalPhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef1"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });
  });
}
