library intl_phone_field;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './countries.dart';
import './phone_number.dart';

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;

  /// For validator to work, turn [autoValidate] to [false]
  final FutureOr<String?> Function(String?)? validator;
  final bool autoValidate;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;

  /// List of 2 Letter ISO Codes of countries to show. Defaults to showing the inbuilt list of all countries.
  final List<String>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Placeholder Text to Display in Searchbar for searching countries
  final String searchText;

  /// Color of the country code
  final Color? countryCodeTextColor;

  /// Position of an icon [leading, trailing]
  final IconPosition iconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropDownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;

  final TextInputAction? textInputAction;

  IntlPhoneField({
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    this.autoValidate = true,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
    this.searchText = 'Search by Country Name',
    this.countryCodeTextColor,
    this.iconPosition = IconPosition.leading,
    this.dropDownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode,
    this.showCountryFlag = true,
    this.invalidNumberMessage,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null ? countries : countries.where((country) => widget.countries!.contains(country.code)).toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere((country) => number.startsWith(country.dialCode), orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry =
          _countryList.firstWhere((item) => item.code == (widget.initialCountryCode ?? 'US'), orElse: () => _countryList.first);
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    filteredCountries = _countryList.where((country) => country.name.toLowerCase().contains(value.toLowerCase())).toList();
                    if (this.mounted) setState(() {});
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
                          leading: Image.asset(
                            'assets/flags/${filteredCountries[index].code.toLowerCase()}.png',
                            package: 'intl_phone_field',
                            width: 32,
                          ),
                          title: Text(
                            filteredCountries[index].name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            '+${filteredCountries[index].dialCode}',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            _selectedCountry = filteredCountries[index];
                            widget.onCountryChanged?.call(
                              PhoneNumber(
                                countryISOCode: _selectedCountry.code,
                                countryCode: '+${_selectedCountry.dialCode}',
                                number: '',
                              ),
                            );
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
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: number,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onSubmitted,
      decoration: widget.decoration.copyWith(
        prefix: _buildFlagsButton(),
        counterText: !widget.enabled ? '' : null,
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(
          PhoneNumber(
            countryISOCode: _selectedCountry.code,
            countryCode: '+${_selectedCountry.dialCode}',
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        final phoneNumber = PhoneNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.dialCode}',
          number: value,
        );
        // validate here to take care of async validation
        if (widget.autoValidate)
          validatorMessage = value.length != _selectedCountry.maxLength ? (widget.invalidNumberMessage ?? 'Invalid Mobile Number') : null;
        if (validatorMessage == null) validatorMessage = await widget.validator?.call(phoneNumber.completeNumber);
        widget.onChanged?.call(phoneNumber);
      },
      validator: (value) => validatorMessage,
      maxLength: _selectedCountry.maxLength,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  DecoratedBox _buildFlagsButton() {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.enabled && widget.showDropdownIcon && widget.iconPosition == IconPosition.leading) ...[
                widget.dropDownIcon,
                SizedBox(width: 4),
              ],
              if (widget.showCountryFlag) ...[
                Image.asset(
                  'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                  package: 'intl_phone_field',
                  width: 32,
                ),
                SizedBox(width: 8),
              ],
              FittedBox(
                child: Text(
                  '+${_selectedCountry.dialCode}',
                  style:
                      Theme.of(context).textTheme.bodyText1, //TextStyle(fontWeight: FontWeight.w700, color: widget.countryCodeTextColor),
                ),
              ),
              if (widget.enabled && widget.showDropdownIcon && widget.iconPosition == IconPosition.trailing) ...[
                SizedBox(width: 4),
                widget.dropDownIcon,
              ],
              SizedBox(width: 8),
            ],
          ),
        ),
        onTap: widget.enabled ? _changeCountry : null,
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}
