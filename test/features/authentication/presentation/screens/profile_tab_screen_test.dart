import 'dart:async';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/profile_tab_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/app_widget_tester.dart';
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

  /// يضبط الـ profile mock عشان الـ ProfileTabScreen يقدر يقرأ البيانات في initState
  void setupProfile() {
    when(
      AuthTestInjection.mockAuthenticationBloc.profile,
    ).thenReturn(TestEntities.tProfile);
  }

  // ────────────────────────────────────────────────
  // Lifecycle
  // ────────────────────────────────────────────────

  setUp(() async {
    await BaseTestInjection.init();
    AuthTestInjection.register();
    streamController = StreamController<AuthenticationState>.broadcast();
    setupStream();
    setupProfile();
  });

  tearDown(() async {
    if (!streamController.isClosed) {
      await streamController.close();
    }
    EasyLoading.dismiss();
    await BaseTestInjection.dispose();
  });

  group('ProfileTabScreen', () {
    // ────────────────────────────────────────────────
    // UI Rendering
    // ────────────────────────────────────────────────
    group('ProfileTabScreen – UI Rendering', () {
      testWidgets('Displays all four input fields.', (tester) async {
        await tester.pumpApp(
          screen: const ProfileTabScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key(WidgetKeys.fullNameFormField)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key(WidgetKeys.emailFormField)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key(WidgetKeys.phoneFormField)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key(WidgetKeys.addressFormField)),
          findsOneWidget,
        );
      });

      testWidgets('Displays the HeaderSection with user email.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const ProfileTabScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(find.byType(HeaderSection), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(HeaderSection),
            matching: find.text(TestEntities.tProfile.email),
          ),
          findsOneWidget,
        );
      });

      testWidgets('Fields are pre-filled with profile data from the BLoC.', (
        tester,
      ) async {
        await tester.pumpApp(
          screen: const ProfileTabScreen(),
          blocs: [authProvider()],
        );
        await tester.pumpAndSettle();

        expect(
          find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.text(TestEntities.tProfile.name),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.byKey(const Key(WidgetKeys.emailFormField)),
            matching: find.text(TestEntities.tProfile.email),
          ),
          findsOneWidget,
        );
      });

      testWidgets(
        'Update Profile button is hidden by default (no editing mode).',
        (tester) async {
          await tester.pumpApp(
            screen: const ProfileTabScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();

          expect(
            find.byKey(const Key(WidgetKeys.updateProfileElevatedButton)),
            findsNothing,
          );
        },
      );

      testWidgets(
        'Update Profile button appears after tapping a field to edit.',
        (tester) async {
          await tester.pumpApp(
            screen: const ProfileTabScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();
          final fullNameEditIcon = find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.byType(Bounceable),
          );

          await tester.scrollUntilVisible(
            fullNameEditIcon,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(fullNameEditIcon);
          await tester.pump();

          // ✅ tap على الـ edit icon عشان يفتح editing mode
          await tester.tap(fullNameEditIcon);
          await tester.pump();
          final fullNameTextField = find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.byType(TextFormField),
          );
          await tester.enterText(fullNameTextField, '');
          await tester.pump();
          final visibilityWidget = tester.widget<Visibility>(
            find.ancestor(
              of: find.byKey(const Key(WidgetKeys.updateProfileElevatedButton)),
              matching: find.byType(Visibility),
            ),
          );
          expect(visibilityWidget.visible, isTrue);
        },
      );
    });

    // ────────────────────────────────────────────────
    // Form Validation
    // ────────────────────────────────────────────────
    group('ProfileTabScreen – Form Validation', () {
      testWidgets(
        'No UpdateUserDataEvent is dispatched when fullName is cleared and form submitted.',
        (tester) async {
          await tester.pumpApp(
            screen: const ProfileTabScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();

          // ✅ الـ onTap موجود على الـ Bounceable (edit icon) جوه الـ fullNameField
          final fullNameEditIcon = find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.byType(Bounceable),
          );

          await tester.scrollUntilVisible(
            fullNameEditIcon,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(fullNameEditIcon);
          await tester.pump();

          // ✅ tap على الـ edit icon عشان يفتح editing mode
          await tester.tap(fullNameEditIcon);
          await tester.pump();

          // ✅ مسح الـ fullName
          final fullNameTextField = find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.byType(TextFormField),
          );
          await tester.enterText(fullNameTextField, '');
          await tester.pump();

          // ✅ tap على الـ update button
          final updateButton = find.byKey(
            const Key(WidgetKeys.updateProfileElevatedButton),
          );
          await tester.ensureVisible(updateButton);
          await tester.pumpAndSettle();

          await tester.tap(updateButton);
          await tester.pumpAndSettle();

          verifyNever(
            AuthTestInjection.mockAuthenticationBloc.add(
              UpdateUserDataEvent(
                updateDataParams: TestParams.tUserUpdateDataParams,
              ),
            ),
          );
        },
      );
    });

    // ────────────────────────────────────────────────
    // BLoC State Reactions
    // ────────────────────────────────────────────────
    group('ProfileTabScreen – BLoC State Reactions', () {
      testWidgets('EasyLoading is shown during AuthenticationLoadingState.', (
        tester,
      ) async {
        setupStream(initialState: const AuthenticationLoadingState());

        await tester.pumpApp(
          screen: const ProfileTabScreen(),
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

      testWidgets('Shows a success SnackBar upon UpdateProfileSuccessState.', (
        tester,
      ) async {
        setupStream();

        await tester.pumpApp(
          screen: const ProfileTabScreen(),
          blocs: [authProvider()],
        );

        streamController.add(const UpdateProfileSuccessState());
        await tester.pumpAndSettle();

        expect(
          find.text(AppStrings.updateProfileSuccessMessage),
          findsOneWidget,
        );

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

      testWidgets('Shows an error SnackBar upon AuthenticationFailureState.', (
        tester,
      ) async {
        const failureMsg = 'Update failed';
        setupStream(
          initialState: const AuthenticationFailureState(
            failureMessage: failureMsg,
          ),
        );

        await tester.pumpApp(
          screen: const ProfileTabScreen(),
          blocs: [authProvider()],
        );

        streamController.add(
          const AuthenticationFailureState(failureMessage: failureMsg),
        );
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.failureMessage), findsOneWidget);

        EasyLoading.dismiss();
        await tester.pump(const Duration(milliseconds: 300));
      });

      testWidgets(
        'Fields reset to read-only after UpdateProfileSuccessState.',
        (tester) async {
          setupStream();

          await tester.pumpApp(
            screen: const ProfileTabScreen(),
            blocs: [authProvider()],
          );
          await tester.pumpAndSettle();

          // ✅ scroll للـ fullName field الأول
          final fullNameEditIcon = find.descendant(
            of: find.byKey(const Key(WidgetKeys.fullNameFormField)),
            matching: find.byType(Bounceable),
          );

          await tester.scrollUntilVisible(
            fullNameEditIcon,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(fullNameEditIcon);
          await tester.pump();

          // ✅ tap عشان يفتح editing mode
          await tester.tap(fullNameEditIcon);
          await tester.pump();

          // ✅ تأكد إن الـ update button ظهر (editing mode اشتغل)
          expect(
            tester
                .widget<Visibility>(
                  find.ancestor(
                    of: find.byKey(
                      const Key(WidgetKeys.updateProfileElevatedButton),
                    ),
                    matching: find.byType(Visibility),
                  ),
                )
                .visible,
            isTrue,
          );

          // ✅ إرسال الـ success state
          streamController.add(const UpdateProfileSuccessState());

          await tester.pumpAndSettle();

          expect(
            find.byKey(const Key(WidgetKeys.updateProfileElevatedButton)),
            findsNothing,
          );

          EasyLoading.dismiss();
          await tester.pump(const Duration(milliseconds: 300));
        },
      );
    });

    // ────────────────────────────────────────────────
    // Scrollability
    // ────────────────────────────────────────────────
    group('ProfileTabScreen – Scrollability', () {
      testWidgets('Screen scrolls without overflow errors.', (tester) async {
        await tester.pumpApp(
          screen: const ProfileTabScreen(),
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
