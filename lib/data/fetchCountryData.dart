
Future<Map<String, String>> fetchCountryData() async {
  await Future.delayed(const Duration(seconds: 2));
  return {
    'Russia': '+7',
    'Ukraine': '+380',
    'USA': '+1',
    'UK': '+44',
    'Canada': '+1',
    'Pakistan': 'эээ'
  };
}