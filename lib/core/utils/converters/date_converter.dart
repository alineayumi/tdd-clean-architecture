class DateToStringConverter {
  static String convert(DateTime date) {
    List<String> dateSplit = date.toString().split(' ');
    return dateSplit.first;
  }
}
