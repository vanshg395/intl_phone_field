import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:test/test.dart';

void main() {
  group('Italy', () {
    test('is listed as Italy with the +39 dial code', () {
      Country italy = countries.firstWhere((country) => country.code == "IT");
      expect(italy.name, "Italy");
      expect(italy.dialCode, "39");
      expect(italy.nameTranslations["fr"], "Italie");
    });

    test('look up an Italian mobile number', () {
      Country country = PhoneNumber.getCountry("+393123456789");
      expect(country.code, "IT");
    });

    test('an Italian mobile number is valid', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(completeNumber: "+393123456789");
      expect(phoneNumber.countryISOCode, "IT");
      expect(phoneNumber.number, "3123456789");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('a Swiss number is still Swiss', () {
      expect(PhoneNumber.getCountry("+41791234567").code, "CH");
    });
  });

  group('Vatican City', () {
    test('uses +39 06 698 and does not shadow Italy', () {
      expect(PhoneNumber.getCountry("+390669812345").code, "VA");
      expect(PhoneNumber.getCountry("+390612345678").code, "IT");
    });
  });

  group('Cayman Islands', () {
    test('uses the +1 345 dial code', () {
      Country cayman = countries.firstWhere((country) => country.code == "KY");
      expect(cayman.fullCountryCode, "1345");
    });
  });
}
