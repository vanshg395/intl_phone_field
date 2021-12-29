import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Intl Phone Field',
        home: Scaffold(
          appBar: AppBar(title: Text("")),
          body: IntlPhoneField(
            initialValue: phoneNumber,
          ),
        ));
  }
}

void main() {
  testWidgets('Test intl_phone_field setup with completeNumber',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestWidget(
      phoneNumber: '+447891234567',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('Test intl_phone_field setup with Guernsey number: +441481960194',
          (WidgetTester tester) async {
        await tester.pumpWidget(TestWidget(
          phoneNumber: '+441481960194',
        ));

        final countryCodeFinder = find.text('+441481');
        final numberFinder = find.text('960194');
        //final countryISOCodeFinder = find.text('GG');
        //final phoneNumberFinder = find.byType(PhoneNumber);

        expect(countryCodeFinder, findsOneWidget);
        expect(numberFinder, findsOneWidget);
        //expect(countryISOCodeFinder, findsOneWidget);
        //expect(phoneNumberFinder, findsOneWidget);
      });
}
