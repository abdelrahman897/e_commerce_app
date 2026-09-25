import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:e_commerce_app/features/authentication/data/models/address_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/authentication_user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_json.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockApiInterface mockApi;
  late RemoteAuthenticationDataSource dataSource;

  setUp(() {
    mockApi = MockApiInterface();
    dataSource = RemoteAuthenticationDataSource(apiInterface: mockApi);
  });
  group('RemoteAuthenticationDataSource', () {
    group('signInWithCredentials', () {
      test('signIn With Credentials is successfully.', () async {
        when(
          mockApi.post(
            EndPoint.signIn,
            body: TestParams.tSignInParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.signIn),
            ),
          ),
        );
        final result = await dataSource.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        expect(result, isA<AuthenticatedUserModel>());
        expect(result.token, equals(TestConstants.tToken));
      });

      test('signIn With Credentials is error.', () async {
        when(
          mockApi.post(
            EndPoint.signIn,
            body: TestParams.tSignInParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.signIn,
          ),
        );
        Future<AuthenticatedUserModel> result() async => await dataSource
            .signInWithCredentials(params: TestParams.tSignInParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('signIn With Credentials is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.signIn,
            body: TestParams.tSignInParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.signIn),
            ),
          ),
        );
        await dataSource.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        verify(
          mockApi.post(
            EndPoint.signIn,
            body: TestParams.tSignInParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('signUpWithCredentials', () {
      test('signUp With Credentials is successfully.', () async {
        when(
          mockApi.post(
            EndPoint.signUp,
            body: TestParams.tSignUpParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.signUp),
            ),
          ),
        );
        final result = await dataSource.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        expect(result, isA<AuthenticatedUserModel>());
        expect(result.token, equals(TestConstants.tToken));
      });

      test('signUp With Credentials is error.', () async {
        when(
          mockApi.post(
            EndPoint.signUp,
            body: TestParams.tSignUpParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.signUp,
          ),
        );
        Future<AuthenticatedUserModel> result() async => await dataSource
            .signUpWithCredentials(params: TestParams.tSignUpParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('signUpWithCredentials is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.signUp,
            body: TestParams.tSignUpParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.signUp),
            ),
          ),
        );
        await dataSource.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        verify(
          mockApi.post(
            EndPoint.signUp,
            body: TestParams.tSignUpParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('forgetPassword With Credentials', () {
      test('forgetPassword is successfully.', () async {
        when(
          mockApi.post(
            EndPoint.forgotPassword,
            body: TestParams.tForgetPasswordParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.forgotPassword),
            ),
          ),
        );
        final result = await dataSource.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        );
        expect(result, isA<AuthenticatedUserModel>());
      });
      test('forgetPassword is error.', () async {
        when(
          mockApi.post(
            EndPoint.forgotPassword,
            body: TestParams.tForgetPasswordParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.forgotPassword,
          ),
        );
        Future<AuthenticatedUserModel> result() async =>
            await dataSource.forgetPasswordWithCredentials(
              params: TestParams.tForgetPasswordParams,
            );
        expect(result, throwsA(isA<ServerException>()));
      });
      test('forgetPassword With Credentials is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.forgotPassword,
            body: TestParams.tForgetPasswordParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.forgotPassword),
            ),
          ),
        );
        await dataSource.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        );
        verify(
          mockApi.post(
            EndPoint.forgotPassword,
            body: TestParams.tForgetPasswordParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('update User Data', () {
      test('update User Data is successfully.', () async {
        when(
          mockApi.put(
            EndPoint.updateUserData,
            body: TestParams.tUserUpdateDataParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.updateUserData),
            ),
          ),
        );
        final result = await dataSource.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        expect(result, isA<AuthenticatedUserModel>());
      });
      test('update User Data is error.', () async {
        when(
          mockApi.put(
            EndPoint.updateUserData,
            body: TestParams.tUserUpdateDataParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.updateUserData,
          ),
        );
        Future<AuthenticatedUserModel> result() async => await dataSource
            .updateUserData(params: TestParams.tUserUpdateDataParams);
        expect(result, throwsA(isA<ServerException>()));
      });
      test('update User Data is called exactly one.', () async {
        when(
          mockApi.put(
            EndPoint.updateUserData,
            body: TestParams.tUserUpdateDataParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.authenticationSuccess,
              requestOptions: RequestOptions(path: EndPoint.updateUserData),
            ),
          ),
        );
        await dataSource.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        verify(
          mockApi.put(
            EndPoint.updateUserData,
            body: TestParams.tUserUpdateDataParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('add Address', () {
      test('add Address is successfully', () async {
        when(
          mockApi.post(
            EndPoint.addresses,
            body: TestParams.tAddressParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.addressSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.addresses),
            ),
          ),
        );
        final result = await dataSource.addAddress(
          params: TestParams.tAddressParams,
        );
        expect(result, isA<AddressModel>());
      });
      test('add Address is error', () async {
        when(
          mockApi.post(
            EndPoint.addresses,
            body: TestParams.tAddressParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.addresses,
          ),
        );
        Future<AddressModel> result() async =>
            await dataSource.addAddress(params: TestParams.tAddressParams);
        expect(result, throwsA(isA<ServerException>()));
      });
      test('add Address is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.addresses,
            body: TestParams.tAddressParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.addressSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.addresses),
            ),
          ),
        );
        await dataSource.addAddress(params: TestParams.tAddressParams);
        verify(
          mockApi.post(
            EndPoint.addresses,
            body: TestParams.tAddressParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('delete Address', () {
      test('delete Address is successfully', () async {
        when(
          mockApi.delete(
            '${EndPoint.addresses}/${TestParams.tAddressParams.userId}',
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.addresses),
            ),
          ),
        );
        await expectLater(
          dataSource.deleteAddress(params: TestParams.tAddressParams),
          completes,
        );
      });
      test('delete Address is error.', () async {
        when(
          mockApi.delete(
            '${EndPoint.addresses}/${TestParams.tAddressParams.userId}',
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.addresses,
          ),
        );
        Future<void> result() async =>
            await dataSource.deleteAddress(params: TestParams.tAddressParams);
        expect(result, throwsA(isA<ServerException>()));
      });
      test('delete Address is called exactly one.', () async {
        when(
          mockApi.delete(
            '${EndPoint.addresses}/${TestParams.tAddressParams.userId}',
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.addresses),
            ),
          ),
        );
        await dataSource.deleteAddress(params: TestParams.tAddressParams);
        verify(
          mockApi.delete(
            '${EndPoint.addresses}/${TestParams.tAddressParams.userId}',
          ),
        ).called(1);
      });
    });
  });
}
