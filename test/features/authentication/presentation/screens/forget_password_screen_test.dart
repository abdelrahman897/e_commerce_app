// 📁 test/features/authentication/presentation/screens/forget_password_screen_test.dart

import 'dart:async';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/image_forget_password_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/app_widget_tester.dart';
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
    setupStream();
  });

  tearDown(() async {
    if (!streamController.isClosed) {
      await streamController.close();
    }
    EasyLoading.dismiss();
    await BaseTestInjection.dispose();
  });

  group('ForgetPasswordScreen', () {
    // ────────────────────────────────────────────────
    // UI Rendering
    // ────────────────────────────────────────────────
    group('ForgetPasswordScreen – UI Rendering', () {
      testWidgets('Displays the email field.', (tester) async {
        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key(WidgetKeys.emailFormField)),
          findsOneWidget,
        );
      });

      testWidgets('Displays the Verify Email button.', (tester) async {
        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key(WidgetKeys.forgetPasswordElevatedButton)),
          findsOneWidget,
        );
      });

      testWidgets('Displays the HeaderLogoSection at the top.', (tester) async {
        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(find.byType(HeaderLogoSection), findsOneWidget);
      });

      testWidgets('Displays the ImageForgetPasswordSection.', (tester) async {
        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(find.byType(ImageForgetPasswordSection), findsOneWidget);
      });
    });

    // ────────────────────────────────────────────────
    // Form Validation
    // ────────────────────────────────────────────────
    group('ForgetPasswordScreen – Form Validation', () {
      testWidgets(
        'No ForgetPasswordEvent is dispatched when form is submitted empty.',
        (tester) async {
          await tester.pumpApp(
            screen: const ForgetPasswordScreen(),
            blocs: [authProvider()],
          );

          final verifyButton = find.byKey(
            const Key(WidgetKeys.forgetPasswordElevatedButton),
          );
          await tester.scrollUntilVisible(
            verifyButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(verifyButton);
          await tester.pump();

          await tester.tap(verifyButton);
          await tester.pumpAndSettle();

          verifyNever(
            AuthTestInjection.mockAuthenticationBloc.add(
              ForgetPasswordEvent(
                forgetPasswordParams: TestParams.tForgetPasswordParams,
              ),
            ),
          );
        },
      );

      testWidgets(
        'No ForgetPasswordEvent is dispatched when email is invalid.',
        (tester) async {
          await tester.pumpApp(
            screen: const ForgetPasswordScreen(),
            blocs: [authProvider()],
          );

          final emailField = find.descendant(
            of: find.byKey(const Key(WidgetKeys.emailFormField)),
            matching: find.byType(TextFormField),
          );
          await tester.enterText(emailField, 'invalid-email');
          await tester.pump();

          final verifyButton = find.byKey(
            const Key(WidgetKeys.forgetPasswordElevatedButton),
          );
          await tester.scrollUntilVisible(
            verifyButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.tap(verifyButton);
          await tester.pumpAndSettle();

          verifyNever(
            AuthTestInjection.mockAuthenticationBloc.add(
              ForgetPasswordEvent(
                forgetPasswordParams: TestParams.tForgetPasswordParams,
              ),
            ),
          );
        },
      );

      testWidgets(
        'A ForgetPasswordEvent is dispatched when a valid email is entered.',
        (tester) async {
          await tester.pumpApp(
            screen: const ForgetPasswordScreen(),
            blocs: [authProvider()],
          );

          final emailField = find.descendant(
            of: find.byKey(const Key(WidgetKeys.emailFormField)),
            matching: find.byType(TextFormField),
          );
          await tester.enterText(
            emailField,
            TestParams.tForgetPasswordParams.email,
          );
          await tester.pump();

          final verifyButton = find.byKey(
            const Key(WidgetKeys.forgetPasswordElevatedButton),
          );
          await tester.scrollUntilVisible(
            verifyButton,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(verifyButton);
          await tester.pump();

          await tester.tap(verifyButton);
          await tester.pumpAndSettle();

          verify(AuthTestInjection.mockAuthenticationBloc.add(any)).called(1);
        },
      );
    });

    // ────────────────────────────────────────────────
    // BLoC State Reactions
    // ────────────────────────────────────────────────
    group('ForgetPasswordScreen – BLoC State Reactions', () {
      testWidgets('EasyLoading is shown during AuthenticationLoadingState.', (
        tester,
      ) async {
        setupStream(initialState: const AuthenticationLoadingState());

        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
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

      testWidgets('Shows a success SnackBar upon ForgetPasswordSuccessState.', (
        tester,
      ) async {
        setupStream();

        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );

        streamController.add(const ForgetPasswordSuccessState());
        await tester.pumpAndSettle();

        expect(
          find.text(AppStrings.forgetPasswordSuccessMessage),
          findsOneWidget,
        );

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

      testWidgets('Shows an error SnackBar upon AuthenticationFailureState.', (
        tester,
      ) async {
        const failureMsg = 'Email not found';
        setupStream(
          initialState: const AuthenticationFailureState(
            failureMessage: failureMsg,
          ),
        );

        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
          blocs: [authProvider()],
        );

        streamController.add(
          const AuthenticationFailureState(failureMessage: failureMsg),
        );
        await tester.pumpAndSettle();

        expect(find.text(failureMsg), findsOneWidget);

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });
    });

    // ────────────────────────────────────────────────
    // Scrollability
    // ────────────────────────────────────────────────
    group('ForgetPasswordScreen – Scrollability', () {
      testWidgets('Screen scrolls without overflow errors.', (tester) async {
        await tester.pumpApp(
          screen: const ForgetPasswordScreen(),
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
