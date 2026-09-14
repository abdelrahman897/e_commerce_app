// Suggested path in your project: lib/core/utils/notification_permission_service.dart

import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/utils/local_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Requests the OS notification permission exactly once for the lifetime
/// of the app install.
///
/// Call [requestIfNeeded] from a single, deliberate point in the user
/// journey - right after onboarding finishes, or right after a
/// successful login/register - rather than from app startup, so the
/// system prompt shows up with context instead of on a blank screen.
///
/// It is safe to call this from more than one place (e.g. both the
/// onboarding "Get Started" button and the post-login flow) since the
/// SharedPreferences flag guarantees the actual system prompt only
/// fires once; every call after that is a cheap no-op.
abstract final class NotificationPermissionService {
  NotificationPermissionService._();

  static const String _prefsKey = 'has_requested_notification_permission';

  static Future<void> requestIfNeeded() async {
    final prefs = getIt<SharedPreferences>();
    final alreadyRequested = prefs.getBool(_prefsKey) ?? false;
    if (alreadyRequested) return;

    await getIt<LocalNotificationInterface>().requestPermissions();
    await prefs.setBool(_prefsKey, true);
  }
}
