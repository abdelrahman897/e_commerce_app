// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:equatable/equatable.dart';

typedef LocalizedString = Function(AppLocalizations);

class OnboardingEntity extends Equatable {
  final String imageLightPath;
  final String imageDarkPath;
  final LocalizedString title;
  final LocalizedString body;

  const OnboardingEntity({
    required this.title,
    required this.body,
    required this.imageLightPath,
    required this.imageDarkPath,
  });

  static List<OnboardingEntity> onboardingList = [
    OnboardingEntity(
      title: (AppLocalizations title) => title.onboardingTitleOne,
      body: (AppLocalizations body) => body.onboardingBodyOne,
      imageLightPath: Assets.images.lightOnboardingPageOneBackgroundImg.path,
      imageDarkPath: Assets.images.darkOnboardingPageOneBackgroundImg.path,
    ),
    OnboardingEntity(
      title: (AppLocalizations title) => title.onboardingTitleTwo,
      body: (AppLocalizations body) => body.onboardingBodyTwo,
      imageLightPath: Assets.images.lightOnboardingPageTwoBackgroundImg.path,
      imageDarkPath: Assets.images.darkOnboardingPageTwoBackgroundImg.path,
    ),
    OnboardingEntity(
      title: (AppLocalizations title) => title.onboardingTitleThree,
      body: (AppLocalizations body) => body.onboardingBodyThree,
      imageLightPath: Assets.images.lightOnboardingPageThreeBackgroundImg.path,
      imageDarkPath: Assets.images.darkOnboardingPageThreeBackgroundImg.path,
    ),
  ];

  @override
  List<Object?> get props => [imageLightPath, imageDarkPath, title, body];
}
