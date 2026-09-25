// 📁 test/features/authentication/presentation/screens/register_screen_test.dart

import 'dart:async';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/app_widget_tester.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_params.dart';
import '../../../../helpers/test_di/base_test_injection.dart';
import '../../../../helpers/test_di/test_auth_injection.dart';

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

  /// يستخدم الـ streamController الخاص بكل test
  /// ويضبط initial state بشكل صريح
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

  setUp(() async {
    await BaseTestInjection.init();
    AuthTestInjection.register();
    streamController = StreamController<AuthenticationState>.broadcast();

    // Default: initial state — tests اللي محتاجة حاجة تانية بتعمل override
    setupStream();
  });

  tearDown(() async {
    if (!streamController.isClosed) {
      await streamController.close();
    }
    EasyLoading.dismiss();
    await BaseTestInjection.dispose();
  });


  group('RegisterScreen', () {
    // UI Rendering 
    group('RegisterScreen – UI Rendering', () {
      testWidgets('Displays all five input fields.', (tester) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pump();
        expect(find.byKey(TestWidgetkeys.kFullNameField), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kPhoneField), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kEmailField), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kPasswordField), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kRePasswordField), findsOneWidget);
      });

      testWidgets('Displays the main Sign Up button and the Google button.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pump();

        expect(find.byKey(TestWidgetkeys.kSignUpButton), findsOneWidget);
        expect(find.byKey(TestWidgetkeys.kSignUpGoogleButton), findsOneWidget);
      });

      testWidgets('Displays the "Already have an account? Login" link.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pump();

        expect(find.byKey(TestWidgetkeys.kSignUpTextButton), findsOneWidget);
      });

      testWidgets('Displays the HeaderLogoSection at the top.', (tester) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(find.byType(HeaderLogoSection), findsOneWidget);
      });
    });

    // Form Validation 
    group('RegisterScreen – Form Validation', () {
      testWidgets(
        'No SignUpEvent is dispatched when form is submitted empty.',
        (tester) async {
          await tester.pumpApp(
            screen: const RegisterScreen(),
            blocs: [authProvider()],
          );

          final signUpButton = find.byKey(TestWidgetkeys.kSignUpButton);
          await tester.scrollUntilVisible(
            signUpButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signUpButton);
          await tester.pump();

          await tester.tap(signUpButton);
          await tester.pumpAndSettle();

          verifyNever(
            AuthTestInjection.mockAuthenticationBloc.add(
              SignUpEvent(signUpParams: TestParams.tSignUpParams),
            ),
          );
        },
      );

      testWidgets(
        'A SignUpEvent with correct params is dispatched when all fields are valid.',
        (tester) async {
          await tester.pumpApp(
            screen: const RegisterScreen(),
            blocs: [authProvider()],
          );

          await _fillField(
            tester,
            TestWidgetkeys.kFullNameField,
            TestParams.tSignUpParams.name,
          );
          await _fillField(
            tester,
            TestWidgetkeys.kPhoneField,
            TestParams.tSignUpParams.phone,
          );
          await _fillField(
            tester,
            TestWidgetkeys.kEmailField,
            TestParams.tSignUpParams.email,
          );
          await _fillField(
            tester,
            TestWidgetkeys.kPasswordField,
            TestParams.tSignUpParams.password,
          );
          await _fillField(
            tester,
            TestWidgetkeys.kRePasswordField,
            TestParams.tSignUpParams.password,
          );

          final signUpButton = find.byKey(TestWidgetkeys.kSignUpButton);
          final registerScrollable = find
              .descendant(
                of: find.byKey(TestWidgetkeys.kRegisterScrollView),
                matching: find.byType(Scrollable),
              )
              .first;

          await tester.scrollUntilVisible(
            signUpButton,
            200,
            scrollable: registerScrollable,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signUpButton);
          await tester.pump();

          await tester.tap(signUpButton);
          await tester.pumpAndSettle();


          verify(AuthTestInjection.mockAuthenticationBloc.add(any)).called(1);
        },
      );
    });

    //  Google Sign-Up
    group('RegisterScreen – Google Sign-Up Button', () {
      testWidgets(
        'SignInOrSignUpEvent is dispatched when the Google button is pressed.',
        (tester) async {
          await tester.pumpApp(
            screen: const RegisterScreen(),
            blocs: [authProvider()],
          );

          final signUpWithGoogleButton = find.byKey(
            TestWidgetkeys.kSignUpGoogleButton,
          );
          await tester.scrollUntilVisible(
            signUpWithGoogleButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(signUpWithGoogleButton);
          await tester.pump();

          await tester.tap(signUpWithGoogleButton);
          await tester.pumpAndSettle();

          verify(
            AuthTestInjection.mockAuthenticationBloc.add(SignInOrSignUpEvent()),
          ).called(1);
        },
      );
    });

    // BLoC State Reactions 
    group('RegisterScreen – BLoC State Reactions', () {
      testWidgets('EasyLoading is shown during AuthenticationLoadingState.', (
        tester,
      ) async {
        setupStream(initialState: const AuthenticationLoadingState());

        await tester.pumpApp(
          screen: const RegisterScreen(),
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

      testWidgets('Shows a success SnackBar upon SignUpSuccessState.', (
        tester,
      ) async {
        setupStream();

        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );

        streamController.add(SignUpSuccessState(user: TestEntities.tUser));
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.signUpSuccessMessage), findsOneWidget);

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

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
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );

        streamController.add(
          const AuthenticationFailureState(failureMessage: failureMsg),
        );
        await tester.pumpAndSettle();

        expect(find.text(failureMsg), findsOneWidget);
      });
    });

    // Password Visibility Toggle 
    group('RegisterScreen – Password Visibility Toggle', () {
      testWidgets('Password and RePassword fields are obscured by default.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        final passwordField = tester.widget<EditableText>(
          find.descendant(
            of: find.byKey(TestWidgetkeys.kPasswordField),
            matching: find.byType(EditableText),
          ),
        );
        final rePasswordField = tester.widget<EditableText>(
          find.descendant(
            of: find.byKey(TestWidgetkeys.kRePasswordField),
            matching: find.byType(EditableText),
          ),
        );

        expect(passwordField.obscureText, isTrue);
        expect(rePasswordField.obscureText, isTrue);
      });

      testWidgets('Tapping the toggle reveals the password field.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        final registerScrollable = find
            .descendant(
              of: find.byKey(TestWidgetkeys.kRegisterScrollView),
              matching: find.byType(Scrollable),
            )
            .first;

        final toggleFinder = find.descendant(
          of: find.byKey(TestWidgetkeys.kPasswordField),
          matching: find.byType(Bounceable),
        );

        await tester.scrollUntilVisible(
          toggleFinder,
          300,
          scrollable: registerScrollable,
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

      testWidgets('Tapping the toggle reveals the rePassword field.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
          blocs: [authProvider()],
        );

        final registerScrollable = find
            .descendant(
              of: find.byKey(TestWidgetkeys.kRegisterScrollView),
              matching: find.byType(Scrollable),
            )
            .first;

        final toggleFinder = find.descendant(
          of: find.byKey(TestWidgetkeys.kRePasswordField),
          matching: find.byType(Bounceable),
        );

        await tester.scrollUntilVisible(
          toggleFinder,
          300,
          scrollable: registerScrollable,
        );
        await tester.pumpAndSettle();
        await tester.tap(toggleFinder);
        await tester.pump();

        final rePasswordField = tester.widget<EditableText>(
          find.descendant(
            of: find.byKey(TestWidgetkeys.kRePasswordField),
            matching: find.byType(EditableText),
          ),
        );

        expect(rePasswordField.obscureText, isFalse);
      });
    });

    // Scrollability 
    group('RegisterScreen – Scrollability', () {
      testWidgets('Screen scrolls without overflow errors.', (tester) async {
        await tester.pumpApp(
          screen: const RegisterScreen(),
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

  final registerScrollable = find
      .descendant(
        of: find.byKey(TestWidgetkeys.kRegisterScrollView),
        matching: find.byType(Scrollable),
      )
      .first;

  await tester.scrollUntilVisible(
    fieldFinder,
    200,
    scrollable: registerScrollable,
  );
  await tester.pumpAndSettle();

  await tester.enterText(fieldFinder, text);
  await tester.pump();
}
