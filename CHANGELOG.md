## [3.1.0] - Release

- **Breaking** `validator` function parameter type is [PhoneNumber] now instead of [String].
- Add `width` property to [PickerDialogStyle]
- Add `flagsButtonMargin` property
- Update phone number length of several countries.

## [3.0.1] - Release

- Fix [#146](https://github.com/vanshg395/intl_phone_field/issues/146)

## [3.0.0] - Release

- Add minimal country length.
- Update minimum and maximum length of phone numbers of several countries.
- Support country search by dial code.
- Move flag button to TextFormField's `prefixIcon` (always displayed and get rid of alignment issues).
- Add `dropdownTextStyle`, customize style use for the country dial code.
- Add `disableLengthCheck`, disable view minimum and maximum length check.
- Add a CountryPickerDialog widget and PickerDialogStyle (set of styles to allow the country search dialog customization).
- Add `flagsButtonPadding`, set custom padding around flag button.
- Add `invalidNumberMessage`, te message to be displayed on validation error.
- Add cursor customization options: `cursorColor`, `cursorHeight`, `cursorRadius`, `cursorWidth` and `showCursor`.
- Switch from country List of Maps to List of Country objects.
- `keyboardAppearance` use default `ThemeData.brightness`
- **Breaking** Rename `dropDownIcon` to `dropdownIcon` and `iconPosition` to `dropdownIconPosition`.
- **Breaking** Remove `autovalidate`.
- **Breaking** Add asynchronous validation.

## [2.1.0] - Added more parameters

- **Breaking** dropDownArrowIcon and dropDownArrowColor parameters are now replaced by dropDownIcon.
- Control autovalidateMode of text input added.
- showCountryFlag param added.
- textAlignVertical param added.
- Icon position feature added.
- Setting enabled to false disable the dropdown button too.
- Update maximum length of phone numbers of several countries.
- Minor fixes.

## [2.0.1] - Release

- Update maximum length of phone numbers of several countries.
- Add dropDownArrowIcon parameter.

## [2.0.0] - Null-Safe Compatibility.

- Package is now null-safe.
- onCountryChanged param added.
- Other Fixes.

## [1.4.2] - Improved Documentation.

- Color change for Dropdown Icon and Dialog is now added.

## [1.4.1] - Improved Documentation.

- More Documentation added for properties.

## [1.4.0] - Bug Fixes and improvements.

- Searchbar label text can be now set.
- Picker popup bug fixed.

## [1.3.0] - Added more parameters

- Initial Value can now be set.
- Phone field now returns ISO County code as well in onSaved, onChanged.
- Minor fixes.

## [1.2.0] - Added more common parameters

- Added some more necessary parameters available for a normal textfield.
- Minor fixes.

## [1.1.0] - Added Styling Elements

- Added styling of the country selection button.
- Added support for input formatters.
- Minor fixes.

## [1.0.1] - Release

- A Basic validator added.
- Updated README.

## [1.0.0] - Release

- A Custom Phone Input TextFormField.
