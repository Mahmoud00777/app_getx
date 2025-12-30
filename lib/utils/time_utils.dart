import 'package:intl/intl.dart';

//--------------- Format Time from "12:24:00:123412" to "12:24 PM"

String format12HTime(String timeString) {
  try {
    String sanitized = timeString.split('.')[0];
    List<String> parts = sanitized.split(':');
    int hours = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
    int minutes = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    String period = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours == 0 ? 12 : hours;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';
  } catch (e) {
    print('Error formatting time: $e');
    return timeString;
  }
}

//--------------- Format Time from "12:24 PM" to  "12:24:00:123412"
String format24HTime(String twelveHourTime) {
  try {
    final format = DateFormat('hh:mm a');
    final dateTime = format.parse(twelveHourTime);
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute:00.000000';
  } catch (e) {
    print('Error converting time: $e');
    return twelveHourTime;
  }
}

//--------------- Extract and Format Time from "2024-12-24 09:00:00" to "09:00 AM"
String extractAndFormatTime(String dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString.replaceFirst(' ', 'T'));
    return DateFormat('hh:mm a').format(dateTime);
  } catch (e) {
    print('Error formatting time: $e');
    return dateTimeString;
  }
}

//--------------- format Duration from 14400 to "2h 24m"
String formatDuration(double totalSeconds) {
  // Handle null or invalid input
  if (totalSeconds <= 0) return "0h";

  final seconds = totalSeconds.toInt();
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;

  if (hours > 0 && minutes > 0) {
    return '${hours}h ${minutes}m';
  } else if (hours > 0) {
    return '${hours}h';
  } else if (minutes > 0) {
    return '${minutes}m';
  } else {
    return '${seconds}s';
  }
}

//--------------- format Duration from "2h 24m" to 14400
int parseDurationToSeconds(String durationString) {
  try {
    // Handle empty or null input
    if (durationString.isEmpty) return 0;

    int totalSeconds = 0;

    final hourMatch = RegExp(r'(\d+)h').firstMatch(durationString);
    if (hourMatch != null) {
      totalSeconds += int.parse(hourMatch.group(1)!) * 3600;
    }

    final minuteMatch = RegExp(r'(\d+)m').firstMatch(durationString);
    if (minuteMatch != null) {
      totalSeconds += int.parse(minuteMatch.group(1)!) * 60;
    }

    final secondMatch = RegExp(r'(\d+)s').firstMatch(durationString);
    if (secondMatch != null) {
      totalSeconds += int.parse(secondMatch.group(1)!);
    }

    return totalSeconds;
  } catch (e) {
    print('Error parsing duration: $e');
    return 0;
  }
}

//--------------- Format Time from "09:00:00" to "09:00 AM"
String formatTimeTo12Hour(String time24) {
  try {
    List<String> parts = time24.split(':');
    if (parts.length < 2) return time24; // Return original if invalid format

    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;

    DateTime time = DateTime(2023, 1, 1, hour, minute);

    return DateFormat('hh:mm a').format(time);
  } catch (e) {
    print('Error formatting time: $e');
    return time24; // Return original if parsing fails
  }
}

//--------------- Format Time from "09:00 AM" to "09:00:00"
String format24Hour(String time12) {
  try {
    time12 = time12.trim().toUpperCase();

    final parts = time12.split(' ');
    if (parts.length < 2) return time12; // Return original if no AM/PM

    final timePart = parts[0];
    final period = parts[1];

    final timeComponents = timePart.split(':');
    if (timeComponents.length < 2) return time12;

    int hour = int.tryParse(timeComponents[0]) ?? 0;
    int minute = int.tryParse(timeComponents[1]) ?? 0;

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}:00';
  } catch (e) {
    print('Error converting time: $e');
    return time12; // Return original if parsing fails
  }
}

//--------------- Format Time from "2024-12-24 09:31:59.066668" to "2 month ago"
String timeAgo(String datetimeString) {
  try {
    final DateTime dateTime = DateTime.parse(datetimeString);
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 5) {
      return "Right now";
    } else if (difference.inSeconds < 60) {
      return "${difference.inSeconds} sec ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "$months month${months > 1 ? 's' : ''} ago";
    } else if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      if (years > 5) return "Long time ago";
      return "$years year${years > 1 ? 's' : ''} ago";
    }
    return "";
  } catch (e) {
    return ""; // Return original if parsing fails
  }
}
