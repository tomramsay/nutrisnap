import 'package:intl/intl.dart';

/// DateTime extensions for formatting and comparison.
extension DateTimeExtensions on DateTime {
  /// Format as 'yyyy-MM-dd' for Firestore document IDs.
  String toDateKey() => DateFormat('yyyy-MM-dd').format(this);

  /// Format as human-readable date: 'Mon, 6 Apr'
  String toShortDate() => DateFormat('E, d MMM').format(this);

  /// Format as full date: 'Monday, 6 April 2026'
  String toFullDate() => DateFormat('EEEE, d MMMM yyyy').format(this);

  /// Format as time: '12:35 PM'
  String toTime() => DateFormat('h:mm a').format(this);

  /// Format as relative date: 'Today', 'Yesterday', or 'Mon, 6 Apr'
  String toRelativeDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);

    if (date == today) return 'Today';
    if (date == today.subtract(const Duration(days: 1))) return 'Yesterday';
    if (date == today.add(const Duration(days: 1))) return 'Tomorrow';
    return toShortDate();
  }

  /// Get ISO week number (for weekly summaries).
  String toYearWeek() {
    final dayOfYear = int.parse(DateFormat('D').format(this));
    final weekNumber = ((dayOfYear - weekday + 10) / 7).floor();
    return '$year-W${weekNumber.toString().padLeft(2, '0')}';
  }

  /// Check if same day as another DateTime.
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
