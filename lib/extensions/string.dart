extension StringExtension on String {
  String stripLeft(String pattern) {
    int i = 0;
    while (this.startsWith(pattern, i)) i += pattern.length;
    return this.substring(i);
  }
}
