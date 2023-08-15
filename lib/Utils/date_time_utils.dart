class DateTimeUtils {
  static final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static String getLocaleDate(DateTime date) {
    return "${date.day} ${_months[date.month - 1]} ${date.year}";
  }

  static String getLocalTimeIn12HourFormat(DateTime date) {
    String hour =
        date.hour > 12 ? (date.hour - 12).toString() : date.hour.toString();
    String minute =
        date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    String amPm = date.hour > 12 ? "PM" : "AM";
    return "$hour:$minute $amPm";
  }
}
