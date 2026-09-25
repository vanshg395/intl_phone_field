import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

void main() {
  final cuba = countries.firstWhere((c) => c.code == 'CU');
  final spain = countries.firstWhere((c) => c.code == 'ES');

  Future<List<Country>> pumpDialog(WidgetTester tester) async {
    final selected = <Country>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CountryPickerDialog(
            searchText: 'Search',
            languageCode: 'en',
            countryList: [cuba, spain],
            filteredCountries: [cuba, spain],
            selectedCountry: cuba,
            onCountryChanged: selected.add,
          ),
        ),
      ),
    );
    return selected;
  }

  testWidgets('selects the tapped country', (tester) async {
    final selected = await pumpDialog(tester);

    await tester.tap(find.text(spain.name));
    await tester.pump();

    expect(selected, [spain]);
  });

  testWidgets(
    'tap landing after a search emptied the list does not throw',
    (tester) async {
      final selected = await pumpDialog(tester);

      // The search replaces the filtered list synchronously; the old rows are
      // still on screen until the next frame, which is when the tap lands.
      await tester.enterText(find.byType(TextField), 'zzz');
      await tester.tap(find.text(cuba.name), warnIfMissed: false);
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(selected, [cuba]);
    },
  );
}
