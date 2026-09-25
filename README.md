# E-commerce App

A Flutter e-commerce client for the [Route API](https://ecommerce.routemisr.com/) (`ecommerce.routemisr.com`). The app built with pure Dart programming language. is a mobile-first shopping application that connects to the Route Misr e-commerce REST API. Users can browse categories and brands, search products, manage a cart, save items to a wishlist, authenticate via email/password or Google Sign-In (Firebase), and pay with Stripe.

## Features

- Beautiful onboarding experience
- Language selection (English & Arabic)
- Light & Dark theme support
- User authentication (Login & Register)
- Browse available products
- Search products by name
- Add and remove products from the cart
- Add and remove products from the wishlist
- Update product quantities
- View shopping cart
- Secure online payment
- Multiple payment methods (Credit Card, Wallet, Cash on Delivery)
- Clean and modular architecture
- Object-Oriented Programming (OOP) principles
- State management with Bloc/Cubit
- Localization (English & Arabic)
- Exception handling
- File-based data persistence

## Screenshots & Demo

> The links below open the file on Google Drive.

**Screenshots**
- [Splash & Onboarding](https://drive.google.com/drive/folders/1P01opeapa76Sca081cPYxsSUkaGaVuxt?usp=sharing) |
- [Authentication](https://drive.google.com/drive/folders/1BpZDj8RG2tkNeJWYgiuUc38xPEOKj62J?usp=sharing) |
- [Home](https://drive.google.com/drive/folders/1vZEbTg67081LOZ6qMZ-tZVc6kVA-yH5S?usp=sharing) | 
- [Category](https://drive.google.com/drive/folders/1wz1rTIizRSI9DSdOaJZFw3B4VrxXKNrf?usp=sharing) | 
- [Product](https://drive.google.com/drive/folders/1nDmSVNoPsDyFpR1_dPI0pSqdfyRAmFki?usp=sharing) |
- [Profile](https://drive.google.com/drive/folders/1Ihs-MnuIqJRbYJmFT1LABio_uqihW-mT?usp=sharing) | 
- [Cart](https://drive.google.com/drive/folders/1XKQWP9SmgnpH7_FcAsdIZyo7suNhtsfJ?usp=sharing) |
- [Wishlist](https://drive.google.com/drive/folders/1QpPSo-9uPilbmMSaAm8d3h0q6zZ49MWA?usp=sharing) |
- [Checkout](https://drive.google.com/drive/folders/1BUWI40U88QHJqop-PHRkLcknipvso8Y1?usp=sharing) |

**Demo Video**
- [Watch the app walkthrough](https://drive.google.com/file/d/1R1phrC0_8NETuayUWtikB2lMxMEpwNTD/view?usp=drive_link)


## Prerequisites

Before running this project, make sure you have:

- Flutter SDK compatible with Dart `^3.11.5` (see `pubspec.yaml`)
- A configured Firebase project (`firebase_options.dart` is present; regenerate with FlutterFire CLI if needed)
- Android Studio / Xcode for device builds
- A `.env` file at the project root (see [Environment Variables](#environment-variables))

## Getting Started

### Installation

```bash
git clone <repository-url>
cd e_commerce_app
flutter pub get
```

Create a `.env` file in the project root with the required keys (see below). The file is bundled as an asset in `pubspec.yaml`.

Run code generation if Hive adapters or assets changed:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Running

```bash
flutter run
```

---

## Environment Variables

| Variable           | Used for                                                                   |
| ------------------ | -------------------------------------------------------------------------- |
| `SERVER_CLIENT_ID` | Google Sign-In server client ID                                            |
| `PUBLISHABLE_KEY`  | Stripe publishable key (`Stripe.publishableKey`)                           |
| `SECRET_KEY`       | Stripe secret key (used by `DioPaymentClient` for payment intent requests) |

### Architecture

The project follows **Feature-First Clean Architecture**.

- **core/** contains shared components such as dependency injection, routing, localization, networking, themes, reusable widgets, and utilities.
- **features/** contains independent modules, each organized into:
  - **data** – Models, data sources, and repository implementations.
  - **domain** – Entities, repositories, and use cases.
  - **presentation** – UI, BLoC/Cubit, and widgets.
  - **di** – Dependency injection.
- **test/** contains unit and widget tests.

## Project Structure

```text
lib/
├── core/
│   ├── cubit/              # Shared Cubits
│   ├── di_core/            # Dependency Injection
│   ├── errors/             # Exceptions & Failures
│   ├── extensions/         # Dart & Flutter extensions
│   ├── gen/                # Generated assets & localization files
│   ├── handler/            # General handlers
│   ├── l10n/               # Localization
│   ├── models/             # Shared models
│   ├── network_handler/    # Network configuration
│   ├── params/             # Common parameters
│   ├── resources/          # Colors, fonts, strings, constants
│   ├── responsive/         # Responsive utilities
│   ├── routes_manager/     # App routing
│   ├── services/           # Shared services
│   ├── storage_handler/    # Local storage
│   ├── theme/              # App themes
│   ├── usecases/           # Base use cases
│   ├── utils/              # Utility functions
│   └── widget/             # Reusable widgets
│
├── features/
│   ├── authentication/    # Login, register, profile, addresses
│   ├── cart/              # Cart CRUD
│   ├── categories/        # Categories tab (presentation)
│   ├── checkout/          # Stripe payment flow
│   ├── home/              # Home feed (categories, brands, products)
│   ├── main_layout/       # Bottom navigation shell
│   ├── onboarding/        # First-run onboarding screens
│   ├── products/          # Product list, search, details
│   ├── splash/            # Splash screen
│   └── wishlist/          # Wishlist with Hive cache
├── firebase_options.dart  # Firebase platform config (generated)
├── hive_registrar.g.dart  # Hive adapter registration (generated)
└── main.dart              # App entry point

test/
├── features/
│   ├── authentication/       # Login, register, addresses, profile
│   ├── cart/                 # Cart CRUD
│   ├── checkout/             # Stripe payment flow
│   ├── onboarding/           # First-run onboarding
│   ├── products/             # Product list, search, details
│   └── wishlist/             # Wishlist (data / domain / presentation)
│       ├── data/
│       │   ├── datasources/  # wishlist_remote_data_source_test.dart
│       │   ├── models/       # wishlist_response_model_test.dart
│       │   └── repositories/ # wishlist_repository_imp_test.dart
│       ├── domain/
│       │   └── usecases/     # add/delete/get_wishlist_test.dart
│       └── presentation/
│           └── manager/      # wishlist_bloc_test.dart
│
├── fixtures/                 # Sample API JSON (address_list.json, sign_in_success.json, sign_up_success.json)
├── helpers/
│   ├── mocks/                # Mockito-generated mocks (mock_auth.dart, mock_wishlist.dart, ...)
│   ├── test_data/            # Shared constants, models, entities, params, failures
│   └── test_di/              # getIt setup/reset for tests (base_test_injection.dart)
└── app_widget_tester.dart    # Common widget testing setup
```

Each feature's tests mirror the app's Clean Architecture layers — `data` (data sources, models, repositories), `domain` (use cases), and `presentation` (BLoC/Cubit) — so a test's location always matches the production file it covers.

## App Flow

Splash
↓
Main Onboarding
↓
Choose Language & Theme
↓
Onboarding Pages
↓
Login / Register
↓
Home
↓
Cart / Wishlist
↓
Checkout
↓
Payment
↓
Order Confirmation

## State Management

Feature screens use **BLoC** (`flutter_bloc`). Global app preferences use **Cubit** with `hydrated_bloc` persistence for theme and language.

App-root providers are registered in `main.dart`:

## Testing

The project has unit and BLoC tests per feature, organized to mirror `lib/features` (see [Project Structure](#project-structure)).

**Stack**

- `flutter_test` – core testing framework
- `mockito` (`@GenerateMocks`) – mock generation for data sources, repositories, use cases, and the API/network layer
- `bloc_test` – asserts BLoC/Cubit state emissions
- `dartz` – asserts `Either`/`Left`/`Right` results returned by repositories and use cases

**What's covered per feature**

- Remote data sources (success, error, call-count verification)
- Response/model parsing (`fromJson`, `Equatable` props)
- Repository implementations (online/offline via `NetworkInfo`, cache fallback)
- Use cases (success/failure delegation to the repository)
- BLoC event → state emissions (loading, success, empty, failure)

**Running tests**

```bash
flutter test
```

Regenerate mocks after adding or changing a `@GenerateMocks` list:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Usage

After launching the application, you can:

1. Select your preferred language (English or Arabic).
2. Choose between Light and Dark themes.
3. Complete the onboarding experience.
4. Register a new account or sign in.
5. Browse product categories.
6. Search for products.
7. View product details.
8. Add products to your cart or wishlist.
9. Update cart quantities.
10. Proceed to checkout.
11. Choose a payment method.

## Data Storage

The application uses a **local storage-based approach** to persist user and app data.

### Storage Methods

- **Local Storage (File System / Shared Preferences / Hive / Hydrated Bloc)**
  - Stores user session data (login state).
  - Saves onboarding completion status.
  - Persists selected language and theme preferences.
  - Stores cart and wishlist data (if enabled offline).

### Data Persistence Features

- Save user authentication state locally.
- Keep user preferences (language & theme) across app restarts.
- Maintain cart and wishlist data locally.

### Notes

- No external database is required (Firebase or SQL) in the current version.
- Data is handled using a clean abstraction layer inside `core/storage_handler`.
- Easily extendable to support remote database (e.g., Firebase) in the future.

## Contributing

Contributions, bug reports, and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch off `main` (`git checkout -b feature/your-feature-name`).
3. Make your changes, following the existing Clean Architecture layering (`data` / `domain` / `presentation`).
4. Add or update tests for any new/changed logic (see [Testing](#testing)) and make sure `flutter test` passes.
5. Commit with a clear message and push your branch.
6. Open a Pull Request describing the change and, if relevant, link the issue it addresses.

For larger changes, please open an issue first to discuss what you'd like to change.

## License

This project is licensed under the [MIT License](LICENSE) — see the LICENSE file for the full text.

## Support

for support or questions, please open an issue in the GitHub repository.
