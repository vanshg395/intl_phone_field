library intl_phone_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final bool autoValidate;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onSubmitted;
  final int maxLength;
  final bool enabled;
  final Brightness keyboardAppearance;
  final String initialValue;

  /// 2 Letter ISO Code
  final String initialCountryCode;
  final InputDecoration decoration;
  final TextStyle style;
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;
  final List<TextInputFormatter> inputFormatters;

  IntlPhoneField({
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    this.autoValidate = true,
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
    this.inputFormatters,
    this.maxLength = 10,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  Map<String, String> _selectedCountry =
      countries.firstWhere((item) => item['code'] == 'US');
  List<Map<String, String>> filteredCountries = countries;
  FormFieldValidator<String> validator;
  // final TextInputFormatter formatter =
  //     TextInputFormatter.withFunction((oldValue, newValue) {
  //   if (newValue.text.length <= oldValue.text.length) return newValue;
  //   return newValue.text.length > 10 ? oldValue : newValue;
  // });

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries
          .firstWhere((item) => item['code'] == widget.initialCountryCode);
    }
    validator = widget.autoValidate
        ? (value) => value.length > 12 ? 'Invalid Phone Number' : null
        : widget.validator;
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
      children: <Widget>[
        _buildFlagsButton(),
        SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textAlign: widget.textAlign,
            onTap: () {
              if (widget.onTap != null) widget.onTap();
            },
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: (s) {
              if (widget.onSubmitted != null) widget.onSubmitted(s);
            },
            decoration: widget.decoration,
            style: widget.style,
            onSaved: (value) {
              if (widget.onSaved != null)
                widget.onSaved(
                  PhoneNumber(
                    countryISOCode: _selectedCountry['code'],
                    countryCode: _selectedCountry['dial_code'],
                    number: value,
                  ),
                );
            },
            onChanged: (value) {
              if (widget.onChanged != null)
                widget.onChanged(
                  PhoneNumber(
                    countryISOCode: _selectedCountry['code'],
                    countryCode: _selectedCountry['dial_code'],
                    number: value,
                  ),
                );
            },
            validator: validator,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            enabled: widget.enabled,
            keyboardAppearance: widget.keyboardAppearance,
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
