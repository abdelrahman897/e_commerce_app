// 📁 lib/core/utils/date_formatter.dart

import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

abstract final class DateFormatter {
  DateFormatter._();
  static void initialize() {
    timeago.setLocaleMessages(AppConstants.ar, timeago.ArMessages());
    timeago.setLocaleMessages(AppConstants.en, timeago.EnMessages());
  }

  // Formatting

  // 26/04/2025
  static String format(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date.toLocal());

  /// 2025-04-26 — API
  static String formatIso(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date.toUtc());

  /// 26/04/2025 - 09:30
  static String formatWithTime(DateTime date) =>
      DateFormat('dd/MM/yyyy - HH:mm').format(date.toLocal());

  /// April 26, 2025 | أ  26 أبريل 2025
  static String formatFull(DateTime date, {String locale = AppConstants.en}) =>
      DateFormat.yMMMMd(locale).format(date.toLocal());

  // Relative time —  timeago

  /// منذ 3 أيام / 3 days ago
  static String timeAgo(DateTime date, {String locale = AppConstants.en}) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.isNegative) {
      return locale == AppConstants.ar
          ? AppStrings.inFutureArabic
          : AppStrings.inFuture;
    }

    return timeago.format(date, locale: locale, clock: now);
  }
}
