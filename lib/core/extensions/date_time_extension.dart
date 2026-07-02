import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/utils/date_formatter.dart';

extension DateTimeExtension on DateTime {
  // 26/04/2025
  String get formatted => DateFormatter.format(this);

  // 2025-04-15
  String get formattedIso => DateFormatter.formatIso(this);

  // 26/04/2025 - 09:30
  String get formattedWithTime => DateFormatter.formatWithTime(this);

  // April 26, 2025  أو  26 أبريل 2025
  String formattedFull({String locale = AppConstants.en}) =>
      DateFormatter.formatFull(this, locale: locale);

  // منذ 3 أيام  أو  3 days ago
  String timeAgo({String locale = AppConstants.en}) =>
      DateFormatter.timeAgo(this, locale: locale);

  // هل التاريخ النهارده؟
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  // هل التاريخ أمس؟
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year;
  }

  String smartFormat({String locale = AppConstants.en}) {
    if (isToday) {
      return '${_pad(hour)}:${_pad(minute)}';
    }
    if (isYesterday) {
      return locale == AppConstants.ar
          ? AppStrings.yesterdayArabic
          : AppStrings.yesterday;
    }
    return formatted;
  }

  String _pad(int value) => value.toString().padLeft(2, '0');
}

extension NullableDateTimeExtension on DateTime? {
  // آمن على null — لو null يرجع dash
  String get formattedOrDash =>
      this == null ? AppConstants.emptyDash : this!.formatted;

  String timeAgoOrDash({String locale = AppConstants.en}) =>
      this == null ? AppConstants.emptyDash : this!.timeAgo(locale: locale);
}
