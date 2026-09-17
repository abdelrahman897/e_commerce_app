// ─────────────────────────────────────────────────────────────────────────────
// test/helpers/base_test_injection.dart
//
// المسؤولية الوحيدة: إدارة دورة حياة getIt (reset قبل وبعد كل test)
// لا يسجّل أي mock هنا — ده شغل كل feature injection لوحدها
// ─────────────────────────────────────────────────────────────────────────────

import 'package:get_it/get_it.dart';

final GetIt testGetIt = GetIt.instance;

class BaseTestInjection {
  BaseTestInjection._(); // منع الـ instantiation

  /// استدعيه في أول setUp() قبل أي feature injection
  static Future<void> init() async {
    await testGetIt.reset(dispose: false);
  }

  /// استدعيه في tearDown() بعد كل test
  static Future<void> dispose() async {
    await testGetIt.reset(dispose: false);
  }
}
