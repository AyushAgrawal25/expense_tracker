class DateTimeUtils {
  static final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static String? getMonthFullName(int index) {
    if (index < 1 || index > 12) {
      return null;
    }

    return _months[index - 1];
  }

  static String? getMonthName(int index) {
    if (index < 1 || index > 12) {
      return null;
    }

    return _months[index - 1].substring(0, 3);
  }

  static int getMonthIndex(String month) {
    for (var element in _months) {
      if (element.toLowerCase().contains(month.toLowerCase())) {
        return _months.indexOf(element) + 1;
      }
    }

    return -1;
  }

  static List<String> get getMonthFullNameList {
    return _months;
  }

  static List<String> get getMonthsList {
    List<String> months = [];
    for (var element in _months) {
      months.add(element.substring(0, 3));
    }
    return months;
  }

  /// This function can be used to parse this type of date.
  /// 2019-08-23 09:19:37 PM
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
