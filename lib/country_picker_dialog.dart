import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/helpers.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

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
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final List<String> favorite;
  final PickerDialogStyle? style;
  final String languageCode;

  const CountryPickerDialog({
    Key? key,
    this.favorite = const [],
    required this.searchText,
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;
  late List<Country> _filteredFavoriteCountries;
  late List<Country> _favoriteCountries;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _favoriteCountries = getCountriesByCountriesCode(widget.favorite, widget.filteredCountries);

    _filteredFavoriteCountries = _favoriteCountries;

    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (value) {
                  search(value);
                  if (mounted) setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  if (_filteredFavoriteCountries.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Country item = _filteredFavoriteCountries[index];
                          return _buildCountryPickerItem(item);
                        },
                        childCount: _filteredFavoriteCountries.length,
                      ),
                    ),
                  ],
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final Country item = _filteredCountries[index];
                        return _buildCountryPickerItem(item);
                      },
                      childCount: _filteredCountries.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search(String value) {
    _filteredCountries = widget.countryList
        .stringSearch(value)
        .where((item) => widget.favorite.any((code) => item.code != code))
        .toList()
      ..sort(
        (a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
      );
    _filteredFavoriteCountries = _favoriteCountries.stringSearch(value);
  }

  Widget _buildCountryPickerItem(Country item) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: kIsWeb
              ? Image.asset(
                  'assets/flags/${item.code.toLowerCase()}.png',
                  package: 'intl_phone_field',
                  width: 32,
                )
              : Text(
                  item.flag,
                  style: const TextStyle(fontSize: 18),
                ),
          contentPadding: widget.style?.listTilePadding,
          title: Text(
            item.localizedName(widget.languageCode),
            style: widget.style?.countryNameStyle ?? const TextStyle(fontWeight: FontWeight.w700),
          ),
          trailing: Text(
            '+${item.dialCode}',
            style: widget.style?.countryCodeStyle ?? const TextStyle(fontWeight: FontWeight.w700),
          ),
          onTap: () {
            _selectedCountry = item;
            widget.onCountryChanged(_selectedCountry);
            Navigator.of(context).pop();
          },
        ),
        widget.style?.listTileDivider ?? const Divider(thickness: 1),
      ],
    );
  }
}
