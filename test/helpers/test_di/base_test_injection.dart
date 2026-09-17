import 'package:get_it/get_it.dart';

final GetIt testGetIt = GetIt.instance;

class BaseTestInjection {
  BaseTestInjection._(); 

  static Future<void> init() async {
    await testGetIt.reset(dispose: false);
  }
  
  static Future<void> dispose() async {
    await testGetIt.reset(dispose: false);
  }
}