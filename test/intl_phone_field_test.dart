import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.phoneNumber, this.countryCode}) : super(key: key);

  final String phoneNumber;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Intl Phone Field',
        home: Scaffold(
          appBar: AppBar(title: const Text("")),
          body: IntlPhoneField(
            initialValue: phoneNumber,
            initialCountryCode: countryCode,
          ),
        ));
  }
}

class ValidationTest extends StatefulWidget {
  const ValidationTest({Key? key}) : super(key: key);

  @override
  State<ValidationTest> createState() => _ValidationTestState();
}

class _ValidationTestState extends State<ValidationTest> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            IntlPhoneField(
              showCountryFlag: false,
              validator: (value) {
                if (value?.number == null || value!.number.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  debugPrint('Valid!');
                } else {
                  debugPrint('Invalid!');
                }
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Test intl_phone_field setup with completeNumber', (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });
// FIXME: This test is failing
//   testWidgets('Test intl_phone_field setup with Guernsey number: +441481960194', (WidgetTester tester) async {
//     await tester.pumpWidget(const TestWidget(
//       phoneNumber: '+441481960194',
//       countryCode: 'GG',
//     ));
//
//     final countryCodeFinder = find.text('+44 1481');
//     final numberFinder = find.text('960194');
//
//     expect(countryCodeFinder, findsOneWidget);
//     expect(numberFinder, findsOneWidget);
//   });

  testWidgets('Test intl_phone_field setup with UK number: +447891244567', (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891244567',
      countryCode: 'GB',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891244567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  group('ValidationTest', () {
    testWidgets('Test intl_phone_field validation with empty number', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: const ValidationTest()));

      final validateButtonFinder = find.text('Validate');
      expect(validateButtonFinder, findsOneWidget);
      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle();

      final errorTextFinder = find.text('Please enter some text');
      expect(errorTextFinder, findsOneWidget);
    });

    testWidgets('Test intl_phone_field validation with valid number', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: const ValidationTest()));

      final validateButtonFinder = find.text('Validate');
      expect(validateButtonFinder, findsOneWidget);
      await tester.enterText(find.byType(IntlPhoneField), '+8801715469898');
      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle();

      final errorTextFinder = find.text('Please enter some text');
      expect(errorTextFinder, findsNothing);
    });
  });
}
