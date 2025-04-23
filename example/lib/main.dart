import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Field Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  /*  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  }, */
                  style: const TextStyle(color: Colors.white),

                  // controller: LoginOTPController.to.phoneNumberController,
                  invalidNumberMessage: null,
                  flagsButtonPadding: const EdgeInsets.only(bottom: 10),
                  cursorColor: Colors.black,
                  dropdownIconPosition: IconPosition.trailing,

                  dropdownTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  showDropdownIcon: true,

                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),

                  // dropdownDecoration:
                  //     BoxDecoration(color: AppColors().tContainerColor),
                  decoration: const InputDecoration(
                    focusColor: Colors.orange,
                    contentPadding: EdgeInsets.only(top: 5),
                    counter: SizedBox(),
                    hintText: 'Enter your Mobile number',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),

                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    final phoneNumber = phone.completeNumber;
                    print(phoneNumber);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
