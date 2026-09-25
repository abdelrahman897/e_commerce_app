import 'dart:async';

import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/utils/local_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_authentication_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/app_widget_tester.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_params.dart';
import '../../../../helpers/test_di/base_test_injection.dart';
import '../../../../helpers/test_di/test_auth_injection.dart';

class FakeLocalNotification implements LocalNotificationInterface {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool?> requestPermissions() async => true;

  @override
  Future<void> showOrderNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {}

  @override
  Future<void> cancelNotification(int id) async {}

  @override
  Future<void> cancelAllNotifications() async {}

  @override
  Future<NotificationAppLaunchDetails?> getLaunchDetails() async => null;

  @override
  Stream<NotificationResponse> watchNotificationTaps() =>
      const Stream<NotificationResponse>.empty();
}

void main() {
  provideDummy<AuthenticationState>(const AuthenticationInitialState());

  late StreamController<AuthenticationState> streamController;

  // ────────────────────────────────────────────────
  // Helpers
  // ────────────────────────────────────────────────

  BlocProvider<AuthenticationBloc> authProvider() =>
      BlocProvider<AuthenticationBloc>.value(
        value: AuthTestInjection.mockAuthenticationBloc,
      );

  void setupStream({
    AuthenticationState initialState = const AuthenticationInitialState(),
  }) {
    when(
      AuthTestInjection.mockAuthenticationBloc.state,
    ).thenReturn(initialState);
    when(
      AuthTestInjection.mockAuthenticationBloc.stream,
    ).thenAnswer((_) => streamController.stream);
  }

  // ────────────────────────────────────────────────
  // Lifecycle
  // ────────────────────────────────────────────────

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() async {
    await BaseTestInjection.init();
    AuthTestInjection.register();
    streamController = StreamController<AuthenticationState>.broadcast();
    setupStream();

    // Register fake for LocalNotificationInterface
    testGetIt.registerFactory<LocalNotificationInterface>(
      () => FakeLocalNotification(),
    );

    // Register SharedPreferences instance for NotificationPermissionService
    final prefs = await SharedPreferences.getInstance();
    testGetIt.registerFactory<SharedPreferences>(() => prefs);
  });

  tearDown(() async {
    if (!streamController.isClosed) {
      await streamController.close();
    }
    EasyLoading.dismiss();
    await BaseTestInjection.dispose();
  });

  group('LoginScreen', () {
    // UI Rendering
    group('LoginScreen – UI Rendering', () {
      testWidgets('Displays the email and password fields.', (tester) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        expect(find.byKey(TestWidgetkeys.kEmailField), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kPasswordField), findsOneWidget);
      });

      testWidgets('Displays the Login button and the Google button.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        expect(
          find.byKey(const Key(WidgetKeys.signInElevatedButton)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key(WidgetKeys.signInWithGoogleElevatedButton)),
          findsOneWidget,
        );
      });

      testWidgets('Displays the "Forgot password" link.', (tester) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        expect(
          find.byKey(const Key(WidgetKeys.forgetPasswordTextButton)),
          findsOneWidget,
        );
      });

      testWidgets('Displays the "Don\'t have an account? Sign up" link.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        expect(
          find.byKey(const Key(WidgetKeys.signInTextButton)),
          findsOneWidget,
        );
      });

      testWidgets(
        'Displays the HeaderLogoSection and HeaderAuthenticationSection at the top.',
        (tester) async {
          await tester.pumpApp(
            screen: const LoginScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();
          expect(find.byType(HeaderLogoSection), findsOneWidget);
          expect(find.byType(HeaderAuthenticationSection), findsOneWidget);
        },
      );
    });

    // Form Validation
    group('LoginScreen – Form Validation', () {
      testWidgets(
        'No SignInEvent is dispatched when form is submitted empty.',
        (tester) async {
          await tester.pumpApp(
            screen: const LoginScreen(),
            blocs: [authProvider()],
          );
          final signInButton = find.byKey(
            const Key(WidgetKeys.signInElevatedButton),
          );
          await tester.scrollUntilVisible(
            signInButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signInButton);
          await tester.pump();
          await tester.tap(signInButton);
          await tester.pumpAndSettle();
          verifyNever(
            AuthTestInjection.mockAuthenticationBloc.add(
              SignInEvent(signInParams: TestParams.tSignInParams),
            ),
          );
        },
      );

      testWidgets(
        'A SignInEvent with correct params is dispatched when all fields are valid.',
        (tester) async {
          await tester.pumpApp(
            screen: const LoginScreen(),
            blocs: [authProvider()],
          );
          await _fillField(
            tester,
            TestWidgetkeys.kEmailField,
            TestParams.tSignInParams.email,
          );
          await _fillField(
            tester,
            TestWidgetkeys.kPasswordField,
            TestParams.tSignInParams.password,
          );
          final signInButton = find.byKey(
            const Key(WidgetKeys.signInElevatedButton),
          );
          await tester.scrollUntilVisible(
            signInButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signInButton);
          await tester.pump();

          await tester.tap(signInButton);
          await tester.pumpAndSettle();

          verify(AuthTestInjection.mockAuthenticationBloc.add(any)).called(1);
        },
      );
    });

    // Google Sign-In
    group('LoginScreen – Google Sign-In Button', () {
      testWidgets(
        'SignInOrSignUpEvent is dispatched when the Google button is pressed.',
        (tester) async {
          await tester.pumpApp(
            screen: const LoginScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();
          final signInWithGoogleButton = find.byKey(
            const Key(WidgetKeys.signInWithGoogleElevatedButton),
          );
          await tester.scrollUntilVisible(
            signInWithGoogleButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signInWithGoogleButton);
          await tester.pump();
          await tester.tap(signInWithGoogleButton);
          await tester.pumpAndSettle();
          verify(
            AuthTestInjection.mockAuthenticationBloc.add(SignInOrSignUpEvent()),
          ).called(1);
        },
      );
    });

    // BLoC State Reactions
    group('LoginScreen – BLoC State Reactions', () {
      testWidgets('EasyLoading is shown during AuthenticationLoadingState.', (
        tester,
      ) async {
        setupStream(initialState: const AuthenticationLoadingState());

        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        await tester.pump();

        streamController.add(const AuthenticationLoadingState());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(EasyLoading.isShow, isTrue);

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

      testWidgets('Shows a success SnackBar upon SignInSuccessState.', (
        tester,
      ) async {
        setupStream();
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        streamController.add(SignInSuccessState(user: TestEntities.tUser));
        await tester.pumpAndSettle();
        expect(find.text(AppStrings.loginSuccessMessage), findsOneWidget);
        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

      testWidgets(
        'Shows a success SnackBar upon SignInOrSignUpWithGoogleSuccessState.',
        (tester) async {
          setupStream();

          await tester.pumpApp(
            screen: const LoginScreen(),
            blocs: [authProvider()],
          );

          streamController.add(
            SignInOrSignUpWithGoogleSuccessState(
              user: TestEntities.tUserGoogle,
            ),
          );
          await tester.pumpAndSettle();

          expect(find.text(AppStrings.loginSuccessMessage), findsOneWidget);

          EasyLoading.dismiss();
          await tester.pump(const Duration(milliseconds: 300));
        },
      );

      testWidgets('Shows an error SnackBar upon AuthenticationFailureState.', (
        tester,
      ) async {
        const failureMsg = 'Invalid credentials';
        setupStream(
          initialState: const AuthenticationFailureState(
            failureMessage: failureMsg,
          ),
        );

        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );

        streamController.add(
          const AuthenticationFailureState(failureMessage: failureMsg),
        );
        await tester.pumpAndSettle();
        expect(find.text(AppStrings.failureMessage), findsOneWidget);
      });
    });

    // Password Visibility Toggle
    group('LoginScreen – Password Visibility Toggle', () {
      testWidgets('Password field is obscured by default.', (tester) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        final passwordField = tester.widget<EditableText>(
          find.descendant(
            of: find.byKey(TestWidgetkeys.kPasswordField),
            matching: find.byType(EditableText),
          ),
        );

        expect(passwordField.obscureText, isTrue);
      });

      testWidgets('Tapping the toggle reveals the password field.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        final toggleFinder = find.descendant(
          of: find.byKey(TestWidgetkeys.kPasswordField),
          matching: find.byType(Bounceable),
        );

        await tester.scrollUntilVisible(
          toggleFinder,
          300,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.tap(toggleFinder);
        await tester.pump();

        final passwordField = tester.widget<EditableText>(
          find.descendant(
            of: find.byKey(TestWidgetkeys.kPasswordField),
            matching: find.byType(EditableText),
          ),
        );

        expect(passwordField.obscureText, isFalse);
      });
    });

    // Navigation Links
    group('LoginScreen – Navigation Links', () {
      testWidgets('Tapping "Forgot password" triggers navigation.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );
        final forgetPasswordButton = find.byKey(
          const Key(WidgetKeys.forgetPasswordTextButton),
        );
        await tester.scrollUntilVisible(
          forgetPasswordButton,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(forgetPasswordButton);
        await tester.pump();

        await tester.tap(forgetPasswordButton);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });

      testWidgets('Tapping "Sign up" triggers navigation.', (tester) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );

        final signUpLink = find.byKey(const Key(WidgetKeys.signInTextButton));
        await tester.scrollUntilVisible(
          signUpLink,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(signUpLink);
        await tester.pump();

        await tester.tap(signUpLink);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    });

    // Scrollability
    group('LoginScreen – Scrollability', () {
      testWidgets('Screen scrolls without overflow errors.', (tester) async {
        await tester.pumpApp(
          screen: const LoginScreen(),
          blocs: [authProvider()],
        );

        await tester.drag(
          find.byType(SingleChildScrollView),
          const Offset(0, -3000),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    });
  });
}

Future<void> _fillField(WidgetTester tester, Key key, String text) async {
  final fieldFinder = find.descendant(
    of: find.byKey(key),
    matching: find.byType(TextFormField),
  );

  final loginScrollable = find.byType(Scrollable).first;

  await tester.scrollUntilVisible(
    fieldFinder,
    200,
    scrollable: loginScrollable,
  );
  await tester.pumpAndSettle();

  await tester.enterText(fieldFinder, text);
  await tester.pump();
}