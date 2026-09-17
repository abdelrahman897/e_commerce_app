import 'package:e_commerce_app/core/errors/failures/failures.dart';

import 'test_data.dart';

abstract class TestFailures {
  static ServerFailure get tServerFailure => ServerFailure(
    statusCode: 404,
    message: TestConstants.tServerFailureMessage,
  );
}
