class Country {
  final String name;
  final String flag;
  final String code;
  final String dialCode;

  Country({this.name, this.flag, this.code, this.dialCode});

  Country.fromJson(Map<String, String> m)
      : name = m['name'],
        flag = m['flag'],
        code = m['code'],
        dialCode = m['dial_code'];
}
