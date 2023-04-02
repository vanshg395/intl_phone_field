// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/helpers.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final EdgeInsets? insetPadding;

  final ScrollbarThemeData? scrollbarThemeData;

  final double? elevation;

  final ShapeBorder? shape;

  final List<BoxShadow>? boxShadow;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.insetPadding,
    this.scrollbarThemeData,
    this.elevation,
    this.shape,
    this.boxShadow,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });

  PickerDialogStyle copyWith({
    Color? backgroundColor,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    Widget? listTileDivider,
    EdgeInsets? listTilePadding,
    EdgeInsets? padding,
    EdgeInsets? insetPadding,
    ScrollbarThemeData? scrollbarThemeData,
    double? elevation,
    ShapeBorder? shape,
    List<BoxShadow>? boxShadow,
    Color? searchFieldCursorColor,
    InputDecoration? searchFieldInputDecoration,
    EdgeInsets? searchFieldPadding,
    double? width,
  }) {
    return PickerDialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      countryCodeStyle: countryCodeStyle ?? this.countryCodeStyle,
      countryNameStyle: countryNameStyle ?? this.countryNameStyle,
      listTileDivider: listTileDivider ?? this.listTileDivider,
      listTilePadding: listTilePadding ?? this.listTilePadding,
      padding: padding ?? this.padding,
      insetPadding: insetPadding ?? this.insetPadding,
      scrollbarThemeData: scrollbarThemeData ?? this.scrollbarThemeData,
      elevation: elevation ?? this.elevation,
      shape: shape ?? this.shape,
      boxShadow: boxShadow ?? this.boxShadow,
      searchFieldCursorColor:
          searchFieldCursorColor ?? this.searchFieldCursorColor,
      searchFieldInputDecoration:
          searchFieldInputDecoration ?? this.searchFieldInputDecoration,
      searchFieldPadding: searchFieldPadding ?? this.searchFieldPadding,
      width: width ?? this.width,
    );
  }
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    final defaultHorizontalPadding = 40.0;
    final defaultVerticalPadding = 24.0;
    return Dialog(
      elevation: widget.style?.elevation ?? 20.0,
      insetPadding: widget.style?.insetPadding ??
          EdgeInsets.symmetric(
            vertical: defaultVerticalPadding,
            horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
                ? (mediaWidth - width) / 2
                : defaultHorizontalPadding,
          ),
      shape: widget.style?.shape,
      shadowColor: Colors.black54,
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: widget.style?.backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.style?.searchFieldPadding ?? EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[\d a-z +]+$")),
                  // FilteringTextInputFormatter.allow(RegExp(r"^[a-b]+$"))
                ],
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (value) {
                  _filteredCountries = isNumeric(value)
                      ? widget.countryList
                          .where((country) => country.dialCode.contains(value))
                          .toList()
                      : widget.countryList
                          .where((country) => country.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                  if (this.mounted) setState(() {});
                },
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ScrollbarTheme(
                data: widget.style?.scrollbarThemeData ??
                    ScrollbarThemeData(
                      interactive: true,
                      radius: Radius.circular(24.0),
                      thickness: MaterialStateProperty.resolveWith((_) => 4.0),
                      minThumbLength: 32.0,
                      thumbVisibility:
                          MaterialStateProperty.resolveWith((_) => true),
                      thumbColor: MaterialStateProperty.resolveWith(
                          (states) => Color(0xFFB4B4B4)),
                      trackVisibility:
                          MaterialStateProperty.resolveWith((_) => true),
                      trackColor: MaterialStateProperty.resolveWith(
                          (states) => Color(0xFFEFF0F2)),
                      trackBorderColor: MaterialStateProperty.resolveWith(
                        (states) => Color(0xFFEFF0F2),
                      ),
                    ),
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _selectedCountry = _filteredCountries[index];
                            widget.onCountryChanged(_selectedCountry);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 16.0),
                            padding: EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2.0),
                                  child: Image.asset(
                                    'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                                    package: 'intl_phone_field',
                                    width: 20.0,
                                    height: 14.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _filteredCountries[index].name,
                                          style:
                                              widget.style?.countryNameStyle ??
                                                  TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                        ),
                                      ),
                                      Text(
                                        ' (${_filteredCountries[index].dialCode})',
                                        style: widget.style?.countryCodeStyle ??
                                            TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // widget.style?.listTileDivider ?? Divider(thickness: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
