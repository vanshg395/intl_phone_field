library intl_phone_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country.dart';

import './countries.dart';
import './phone_number.dart';

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final VoidCallback onTap;
  final bool readOnly;
  final FormFieldSetter<PhoneNumber> onSaved;
  final ValueChanged<PhoneNumber> onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onSubmitted;

  /// 2 Letter ISO Code
  final String initialCountryCode;
  final InputDecoration decoration;
  final TextStyle style;
  final bool showDropdownIcon;
  final String countrySearchHintText;

  final BoxDecoration dropdownDecoration;
  final List<TextInputFormatter> formatters;
  final Widget Function(BuildContext,
      {int currentLength, int maxLength, bool isFocused}) buildCounter;

  final int targetLength;
  final String invalidNumberText;

  IntlPhoneField({
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.number,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.countrySearchHintText = 'Search by Country Name',
    this.formatters,
    this.buildCounter,
    this.targetLength = 10,
    this.invalidNumberText = 'Invalid phone number !',
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  Map<String, String> _selectedCountry =
      countries.firstWhere((item) => item['code'] == 'US');
  List<Map<String, String>> filteredCountries = countries;
  FormFieldValidator<String> validator;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries
          .firstWhere((item) => item['code'] == widget.initialCountryCode);
    }
    validator = widget.validator ?? widget.targetLength != null
        ? ((value) => value.length != widget.targetLength
            ? widget.invalidNumberText
            : null)
        : null;
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
                    labelText: widget.countrySearchHintText,
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = countries
                          .where((country) =>
                              country['name'].toLowerCase().contains(value))
                          .toList();
                    });
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
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
                            _selectedCountry = filteredCountries[index];
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFlagsButton(),
        SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textAlign: widget.textAlign,
            onTap: widget.onTap,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onSubmitted,
            decoration: widget.decoration,
            style: widget.style,
            maxLength: widget.targetLength,
            buildCounter: widget.targetLength == null
                ? null
                : (_, {currentLength, maxLength, isFocused}) {
                    return Text("$currentLength/$maxLength",
                        style: TextStyle(
                            color: currentLength != maxLength
                                ? Colors.red
                                : null));
                  },
            onSaved: (value) {
              if (widget.onSaved != null)
                widget.onSaved(
                  PhoneNumber(
                      country: Country.fromJson(_selectedCountry),
                      number: value),
                );
            },
            onChanged: (value) {
              if (widget.onChanged != null)
                widget.onChanged(
                  PhoneNumber(
                      country: Country.fromJson(_selectedCountry),
                      number: value),
                );
            },
            validator: validator,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.formatters,
          ),
        ),
      ],
    );
  }

  DecoratedBox _buildFlagsButton() {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.showDropdownIcon) ...[
                Icon(Icons.arrow_drop_down),
                SizedBox(width: 4)
              ],
              Text(
                _selectedCountry['flag'],
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 8),
              FittedBox(
                child: Text(
                  _selectedCountry['dial_code'],
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        onTap: _changeCountry,
      ),
    );
  }
}
