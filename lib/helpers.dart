import 'package:intl_phone_field/countries.dart';

bool isNumeric(String s) => s.isNotEmpty && int.tryParse(s.replaceAll("+", "")) != null;

String removeDiacritics(String str) {
  var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }

  return str;
}

List<Country> getCountriesByCountriesCode(List<String> countriesCode, List<Country> countries) {
  // Filter the countries based on the provided country codes
  return countries.where((country) => countriesCode.contains(country.code)).toList();
}

extension CountryExtensions on List<Country> {
  List<Country> stringSearch(String search) {
    search = removeDiacritics(search.toLowerCase());
    return where(
      (country) => isNumeric(search) || search.startsWith("+")
          ? country.dialCode.contains(search)
          : removeDiacritics(country.name.replaceAll("+", "").toLowerCase()).contains(search) ||
              country.nameTranslations.values
                  .any((element) => removeDiacritics(element.toLowerCase()).contains(search)),
    ).toList();
  }
}
