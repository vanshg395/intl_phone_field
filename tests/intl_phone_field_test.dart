import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

void main() {
  testWidgets('Test intl_phone_field setup with completeNumber', (WidgetTester tester) async{
    await tester.pumpWidget(IntlPhoneField(initialValue: '+447891234567',));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });
}