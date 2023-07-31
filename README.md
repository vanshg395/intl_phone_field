# International Phone Field Package
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-9-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![pub package](https://img.shields.io/pub/v/intl_phone_field.svg)](https://pub.dev/packages/intl_phone_field)

A customised Flutter TextFormField to input international phone number along with country code.

This widget can be used to make customised text field to take phone number input for any country along with an option to choose country code from a dropdown.

## Screenshots

<img src="https://github.com/vanshg395/intl_phone_field/blob/master/1.png?raw=true" height="500px"> <img src="https://github.com/vanshg395/intl_phone_field/blob/master/2.png?raw=true" height="500px"> <img src="https://github.com/vanshg395/intl_phone_field/blob/master/3.png?raw=true" height="500px">

## Installing

To use this package:

Run this command:

```yaml
flutter pub add intl_phone_field
```

Or, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  intl_phone_field: ^3.1.0
```

## How to Use

Simply create a `IntlPhoneField` widget, and pass the required params:

```dart
IntlPhoneField(
    decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
            borderSide: BorderSide(),
        ),
    ),
    initialCountryCode: 'IN',
    onChanged: (phone) {
        print(phone.completeNumber);
    },
)
```

Use `initialCountryCode` to set an initial Country Code.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

Comment on Issue or Pull Request, asking @all-contributors to add a contributor:

```shell
@all-contributors please add @<username> for <contributions>
```

**\<contributions>**: See the [Emoji Key (Contribution Types Reference)](https://allcontributors.org/docs/en/emoji-key) for a list of valid contribution types.

## Maintainers
- [Vansh Goel](https://github.com/vanshg395/)
- [Alex N'Guessan](https://github.com/marcaureln/)

## Contributors
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://vansh.codes"><img src="https://avatars.githubusercontent.com/u/34906419?v=4?s=100" width="100px;" alt="Vansh Goel"/><br /><sub><b>Vansh Goel</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=vanshg395" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://twitter.com/Kunodayo_oboete"><img src="https://avatars.githubusercontent.com/u/23455702?v=4?s=100" width="100px;" alt="KNO3"/><br /><sub><b>KNO3</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=kno3a87" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.techarge.co.uk"><img src="https://avatars.githubusercontent.com/u/850493?v=4?s=100" width="100px;" alt="Ling Li"/><br /><sub><b>Ling Li</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=lingster" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://linkedin.com/in/anggaraputrapratama"><img src="https://avatars.githubusercontent.com/u/75307272?v=4?s=100" width="100px;" alt="Anggara Putra Pratama"/><br /><sub><b>Anggara Putra Pratama</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=anggaraputrapratama" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://geewax.org"><img src="https://avatars.githubusercontent.com/u/112928?v=4?s=100" width="100px;" alt="JJ Geewax"/><br /><sub><b>JJ Geewax</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=jgeewax" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/KevalPrajapati"><img src="https://avatars.githubusercontent.com/u/63007835?v=4?s=100" width="100px;" alt="Keval Prajapati"/><br /><sub><b>Keval Prajapati</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=KevalPrajapati" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.glaunay.fr"><img src="https://avatars.githubusercontent.com/u/18292489?v=4?s=100" width="100px;" alt="Guillaume Launay"/><br /><sub><b>Guillaume Launay</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=launay12u" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/2000calories"><img src="https://avatars.githubusercontent.com/u/25191098?v=4?s=100" width="100px;" alt="hans.huang"/><br /><sub><b>hans.huang</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=2000calories" title="Code">💻</a> <a href="https://github.com/vanshg395/intl_phone_field/commits?author=2000calories" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/The-Redhat"><img src="https://avatars.githubusercontent.com/u/33162310?v=4?s=100" width="100px;" alt="Gregor Weber"/><br /><sub><b>Gregor Weber</b></sub></a><br /><a href="https://github.com/vanshg395/intl_phone_field/commits?author=The-Redhat" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## LICENSE

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
