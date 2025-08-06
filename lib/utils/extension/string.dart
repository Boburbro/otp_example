extension PhoneNumberFormat on String {
  String get formatAsUzPhone {
    return '998${replaceAll(RegExp(r"\s|-|[()]+"), "")}';
  }
}
