library intl_phone_field;

import 'package:flutter/material.dart';
import './countries.dart';
import './phone_number.dart';

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final Function onPressed;
  final bool readOnly;
  final Function validator;
  final FormFieldSetter<PhoneNumber> onSaved;
  final ValueChanged<PhoneNumber> onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;

  /// 2 Letter ISO Code
  final String initialCountryCode;
  final InputDecoration decoration;
  final TextStyle style;

  IntlPhoneField({
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.onPressed,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  Map<String, dynamic> _selectedCountry =
      countries.where((item) => item['code'] == 'AF').toList()[0];

  List<dynamic> filteredCountries = countries;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries
          .where((item) => item['code'] == widget.initialCountryCode)
          .toList()[0];
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      context: context,
      child: StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: 'Search by Country Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = countries.where((country) {
                        return country['name'].toLowerCase().contains(value);
                      }).toList();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            filteredCountries[index]['flag'],
                            style: TextStyle(fontSize: 30),
                          ),
                          title: Text(
                            filteredCountries[index]['name'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            filteredCountries[index]['dial_code'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            _selectedCountry = countries
                                .where(
                                  (country) =>
                                      country['code'] ==
                                      filteredCountries[index]['code'],
                                )
                                .toList()[0];
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    itemCount: filteredCountries.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          child: Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _selectedCountry['flag'],
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                FittedBox(
                  child: Text(
                    _selectedCountry['dial_code'],
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          onTap: _changeCountry,
        ),
        Expanded(
          child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textAlign: widget.textAlign,
            onTap: widget.onPressed,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onSubmitted,
            decoration: widget.decoration,
            style: widget.style,
            onSaved: (value) {
              widget.onSaved(
                PhoneNumber(
                    countryCode: _selectedCountry['dial_code'], number: value),
              );
            },
            onChanged: (value) {
              widget.onChanged(
                PhoneNumber(
                    countryCode: _selectedCountry['dial_code'], number: value),
              );
            },
            validator: widget.validator,
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
    );
  }
}
