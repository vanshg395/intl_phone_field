String sanitizeInput(String s) {
  String input = s;
  if (s.contains('+')) {
    input = s.replaceAll(RegExp(r'\+'), '');
  }

  return input;
}

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
