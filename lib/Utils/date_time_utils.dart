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

  static int getMonthIndex(String month) {
    return _months.indexOf(month) + 1;
  }

  /**
   * This function can be used to parse this type of date.
   * 2019-08-23 09:19:37 PM
   */
  static DateTime parseDateTime(String dateString) {
    List<String> dateParts = dateString.split(" ");
    List<String> date = dateParts[0].split("-");
    List<String> time = dateParts[1].split(":");
    int hour = int.parse(time[0]);
    if (dateParts[2] == "PM") {
      hour += 12;
    }
    return DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]),
        hour, int.parse(time[1]), int.parse(time[2].substring(0, 2)));
  }

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
