//--------------- Format Date from "24-12-2024" to "2024-12-24"
import 'package:intl/intl.dart';

//--------------- Format Date from "24-12-2024" to "2024-12-24"
String formatDateddMM(String inputDate) {
  try {
    // Parse the input date into a DateTime object
    DateTime parsedDate =
        DateTime.parse(inputDate.split('-').reversed.join('-'));

    // Format the date back as 'yyyy-MM-dd'
    return '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}';
  } catch (e) {
    return inputDate;
  }
}

//--------------- Format Date from "2024-12-24" to "24-12-2024"
String formatDateMMdd(String inputDate) {
  try {
    DateTime parsedDate = DateTime.parse(inputDate);

    String day = parsedDate.day.toString().padLeft(2, '0');
    String month = parsedDate.month.toString().padLeft(2, '0');
    String year = parsedDate.year.toString();

    // Format the date as 'dd-MM-yyyy'
    return '$day-$month-$year';
  } catch (e) {
    return inputDate;
  }
}

//--------------- Format Date from "2024-12-24 09:00:00" to "2024-12-24"
String extractDate(String dateTimeString) {
  return dateTimeString.substring(0, 10);
}

//--------------- Format Time from "2024-12-24 09:00:00" to "09:00:00"

String extractTime(String dateTimeString) {
  return dateTimeString.substring(11, 19);
}

//--------------- Format Date from "24th December 2024" to "24-12-2024"
String formatNumericDate(String inputDate) {
  try {
    final cleanedDate = inputDate.replaceAll(RegExp(r'(st|nd|rd|th)'), '');
    final parsedDate = DateFormat('d MMMM yyyy').parse(cleanedDate);

    return DateFormat('dd-MM-yyyy').format(parsedDate);
  } catch (e) {
    print("Error formatting date: $e");
    return inputDate; // Fallback
  }
}
