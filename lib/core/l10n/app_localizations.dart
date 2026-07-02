import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Main onboarding screen title shown before theme/language selection
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get mainOnboardingTitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Main onboarding screen subtitle explaining the personalization step
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get mainOnboardingBody;

  /// No description provided for @fullNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Your full name'**
  String get fullNameTitle;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Your E-mail'**
  String get emailTitle;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get passwordTitle;

  /// No description provided for @mobileNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Your mobile number'**
  String get mobileNumberTitle;

  /// No description provided for @addressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Address'**
  String get addressTitle;

  /// First onboarding step title
  ///
  /// In en, this message translates to:
  /// **'Choose Products'**
  String get onboardingTitleOne;

  /// First onboarding step description explaining product browsing
  ///
  /// In en, this message translates to:
  /// **'Browse thousands of products across every category from fashion and electronics to home essentials and beyond. Filter by price, brand, or rating to find exactly what you\'re looking for in seconds.'**
  String get onboardingBodyOne;

  /// Second onboarding step title
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get onboardingTitleTwo;

  /// Second onboarding step description explaining payment security
  ///
  /// In en, this message translates to:
  /// **'Pay securely with your preferred method — credit card, debit card, or digital wallet. Your transactions are always encrypted and protected, so you can shop with complete peace of mind.'**
  String get onboardingBodyTwo;

  /// Third onboarding step title
  ///
  /// In en, this message translates to:
  /// **'Get Your Order'**
  String get onboardingTitleThree;

  /// Third onboarding step description explaining delivery tracking
  ///
  /// In en, this message translates to:
  /// **'Sit back and relax while we handle the rest. Track your delivery in real time and receive your order right at your doorstep, fast and hassle-free.'**
  String get onboardingBodyThree;

  /// No description provided for @mostSelling.
  ///
  /// In en, this message translates to:
  /// **'Most Selling Products'**
  String get mostSelling;

  /// No description provided for @brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get brands;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'what do you search for?'**
  String get searchHint;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @wishList.
  ///
  /// In en, this message translates to:
  /// **'WishList'**
  String get wishList;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Button label to skip the onboarding flow
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Button label to go to the next onboarding step
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Button label to go to the previous onboarding step
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// Login screen main title greeting returning users
  ///
  /// In en, this message translates to:
  /// **'Welcome Back To Route'**
  String get loginTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Login screen subtitle instructing users to sign in
  ///
  /// In en, this message translates to:
  /// **'Please sign in with your mail'**
  String get loginSubTitle;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'E-mail Address'**
  String get email;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Image Not Found'**
  String get notFound;

  /// Placeholder text inside the email input field
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your New Password'**
  String get newPasswordHint;

  /// Label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @resetCode.
  ///
  /// In en, this message translates to:
  /// **'Reset Code'**
  String get resetCode;

  /// No description provided for @resetCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Code'**
  String get resetCodeHint;

  /// No description provided for @titleWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get titleWelcome;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// Placeholder text inside the password input field
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Label for the re-enter password input field during registration
  ///
  /// In en, this message translates to:
  /// **'Re-Password'**
  String get rePassword;

  /// Placeholder text inside the re-enter password input field
  ///
  /// In en, this message translates to:
  /// **'Enter password again'**
  String get rePasswordHint;

  /// Label or title for the confirm password step or field
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Password'**
  String get confirmPassword;

  /// Link or button label to initiate the forgot password flow
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Button label to submit the password reset request
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Button label for the login action
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Button label for the sign up / registration action
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// Label for the full name input field during registration
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Placeholder text inside the full name input field
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get fullNameHint;

  /// Label for the phone number input field
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get phoneNumber;

  /// Placeholder text inside the mobile number input field
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get phoneNumberHint;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Divider label between login options, e.g. between form and Google login
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// Button label for Google OAuth login
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// Prompt text shown on login screen for new users, followed by a signup link
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get doNotHaveAccount;

  /// Prompt text shown on signup screen for existing users, followed by a login link
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Title or button label for the email verification screen
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// Description on the verify email screen showing where the code was sent
  ///
  /// In en, this message translates to:
  /// **'We emailed you the six-digit code to {email}'**
  String verifyEmailDescription(String email);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @sold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get sold;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route App'**
  String get route;

  /// No description provided for @cartItemDetails.
  ///
  /// In en, this message translates to:
  /// **'Cart Item Details'**
  String get cartItemDetails;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get addressHint;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Your Profile'**
  String get updateProfile;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to payment'**
  String get proceedToPayment;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'SignOut'**
  String get signOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
