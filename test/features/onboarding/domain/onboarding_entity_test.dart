import 'package:e_commerce_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingEntity', () {
    group('onboardingList', () {
      test('onboardingList has exactly 3 items', () {
        expect(OnboardingEntity.onboardingList, hasLength(3));
      });

      test('each item has non-empty paths', () {
        for (final item in OnboardingEntity.onboardingList) {
          expect(item.imageLightPath, isNotEmpty);
          expect(item.imageDarkPath, isNotEmpty);
        }
      });
    });

    group('equatable', () {
      test('Two instance identical', () {
        final item = OnboardingEntity.onboardingList[0];
        final copy = OnboardingEntity(
          title: item.title,
          body: item.body,
          imageLightPath: item.imageLightPath,
          imageDarkPath: item.imageDarkPath,
        );
        expect(item, equals(copy));
        expect(item.hashCode, equals(copy.hashCode));
      });

      test('different instances are not equal', () {
        final first = OnboardingEntity.onboardingList[0];
        final second = OnboardingEntity.onboardingList[1];
        expect(first, isNot(equals(second)));
      });

      test('props contain 4 elements', () {
        final item = OnboardingEntity.onboardingList[0];
        expect(item.props, hasLength(4));
      });
    });
  });
}
