// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter_test/flutter_test.dart';
import 'package:intl_field_phone/countries.dart';
import 'package:test/test.dart';
import 'package:intl_field_phone/phone_number.dart';

void main() {
  group('PhoneNumber', () {
    test('create a phone number', () {
      PhoneNumber phoneNumber = PhoneNumber(countryISOCode: "CD", countryCode: "+243", number: "812167999");
      String actual = phoneNumber.completeNumber;
      String expected = "+243812167999";

      expect(actual, expected);
      expect(phoneNumber.isValidNumber(), true);
    });

    test('create a Guernsey number', () {
      PhoneNumber phoneNumber = PhoneNumber(countryISOCode: "GG", countryCode: "+441481", number: "960194");
      String actual = phoneNumber.completeNumber;
      String expected = "+441481960194";

      expect(actual, expected);
      expect(phoneNumber.isValidNumber(), true);
    });

    test('look up CD as a country code', () {
      Country country = PhoneNumber.getCountry("+243812167999");
      expect(country.name, "Congo, The Democratic Republic of the Congo");
      expect(country.code, "CD");
      expect(country.regionCode, "");
    });

    test('create with empty complete number', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(completeNumber: "");
      expect(phoneNumber.countryISOCode, "");
      expect(phoneNumber.countryCode, "");
      expect(phoneNumber.number, "");
      expect(() => phoneNumber.isValidNumber(), throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('create HK  number +85212345678', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(completeNumber: "+85212345678");
      expect(phoneNumber.countryISOCode, "HK");
      expect(phoneNumber.countryCode, "852");
      expect(phoneNumber.number, "12345678");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('Number is too short number +8521234567', () {
      PhoneNumber ph = PhoneNumber.fromCompleteNumber(completeNumber: "+8521234567");
      expect(() => ph.isValidNumber(), throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('cannot create from too long number +852123456789', () {
      PhoneNumber ph = PhoneNumber.fromCompleteNumber(completeNumber: "+852123456789");

      expect(() => ph.isValidNumber(), throwsA(const TypeMatcher<NumberTooLongException>()));
    });

    test('create CD PhoneNumber from +243812167999', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(completeNumber: "+243812167999");
      expect(phoneNumber.countryISOCode, "CD");
      expect(phoneNumber.countryCode, "243");
      expect(phoneNumber.number, "812167999");
      expect(phoneNumber.isValidNumber(), true);
    });

    //Add test
    test('create CG PhoneNumber from +242057009244', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(completeNumber: "+242057009244");
      expect(phoneNumber.countryISOCode, "CG");
      expect(phoneNumber.countryCode, "242");
      expect(phoneNumber.number, "057009244");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('create alpha character in  PhoneNumber from +44abcdef', () {
      expect(() => PhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });

    test('create alpha character in  PhoneNumber from +44abcdef1', () {
      expect(() => PhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef1"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });
  });
}
