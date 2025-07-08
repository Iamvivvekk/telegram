import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryPickerProvider = StateProvider((ref) {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India',
    displayNameNoCountryCode: 'India',
    e164Key: '',
  );
});
