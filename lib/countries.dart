import 'package:intl_country_data/intl_country_data.dart';

class Country {
  final String name;
  final Map<String, String> nameTranslations;
  final String flag;
  final String code;
  final String dialCode;
  final String regionCode;
  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.nameTranslations,
    required this.minLength,
    required this.maxLength,
    this.regionCode = "",
  });

  factory Country.fromIntlCountryData(IntlCountryData countryData) => Country(
        name: countryData.name,
        flag: countryData.flag,
        code: countryData.codeAlpha2,
        dialCode: countryData.telephoneCode,
        nameTranslations: countryData.nameTranslations,
        minLength: countryData.telephoneMinLength,
        maxLength: countryData.telephoneMaxLength,
      );

  String get fullCountryCode {
    return dialCode + regionCode;
  }

  String get displayCC {
    if (regionCode != "") {
      return "$dialCode $regionCode";
    }
    return dialCode;
  }

  String localizedName(String languageCode) {
    return nameTranslations[languageCode] ?? name;
  }
}
