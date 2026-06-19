# Praktix

Praktix Mobile App MVP — a career learning platform connecting education, AI, and global expertise.

## Table of contents

- [Architecture](#architecture)
- [Packages used](#packages-used)
- [Setup instructions](#setup-instructions)

## Architecture

Praktix follows a layered structure that separates UI, business rules, and data access, with [Riverpod](https://riverpod.dev) for state management and [go_router](https://pub.dev/packages/go_router) for navigation.

```
lib/
├── app.dart                  # Root widget — MaterialApp.router setup
├── core/                     # Shared, feature-agnostic building blocks
│   ├── constants/            # App-wide constants
│   │   ├── app_assets.dart       # Centralized asset paths
│   │   ├── app_constants.dart    # Misc app-level constants
│   │   ├── app_spacing.dart      # Padding, gaps, responsive sizing
│   │   └── app_strings.dart      # User-facing copy / string keys
│   ├── router/
│   │   └── app_router.dart       # GoRouter routes, redirects, AppRoutes
│   ├── theme/                 # Color tokens, typography, light/dark ThemeData
│   ├── utils/
│   │   └── extensions.dart       # BuildContext / helper extensions
│   └── widgets/                  # Shared, reusable UI components
│       └── (SectionHeader, ProgramCard, ExpertCard, WorkshopCard, ...)
├── data/                      # Data sources, repositories, DTOs/mock data
├── domain/                    # Entities and business logic, independent of UI/data
└── presentation/
    ├── providers/             # Riverpod providers (auth, home, theme, storage)
    └── screens/               # One folder per feature/screen
        ├── about/
        ├── ai_assistant/
        ├── auth/                  # login, register, forgot password
        ├── expert/
        ├── home/                  # home_screen.dart, main_shell.dart (bottom nav)
        ├── onboarding/
        ├── profile/
        ├── program/
        └── splash/
```

**Layer responsibilities**

| Layer | Responsibility |
|---|---|
| `core` | Cross-cutting concerns with no feature ownership: theming, routing, constants, shared widgets, extensions. |
| `domain` | Business entities and rules, independent of how data is fetched or rendered. |
| `data` | Implements data access (currently mock data sources) behind repository contracts defined in `domain`. |
| `presentation/providers` | Riverpod providers bridging `domain`/`data` into the UI as observable state. |
| `presentation/screens` | Feature UI, one folder per screen, built on top of providers and shared widgets. |

**Navigation flow**: `app.dart` configures `MaterialApp.router` with `routerProvider`. `app_router.dart` defines all routes and a `redirect` callback that gates access based on onboarding completion (`localStorageProvider`) and auth state (`authProvider`) — routing users through splash → onboarding → auth → the main `MainShell` (bottom-nav tabs: Home, AI Advisor, About, Profile), with `/program/:id` and `/expert/:id` as detail routes pushed on top.

## Packages used

| Package | Purpose |
|---|---|
| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | State management and dependency injection across providers. |
| [`go_router`](https://pub.dev/packages/go_router) | Declarative routing, redirects, and nested navigation. |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Local key-value persistence (e.g. onboarding-complete flag). |
| [`google_fonts`](https://pub.dev/packages/google_fonts) | Custom typography loaded from Google Fonts. |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | Network image loading with disk/memory caching (avatars, program thumbnails). |
| [`flutter_animate`](https://pub.dev/packages/flutter_animate) | Declarative entrance/transition animations across screens. |
| [`intl`](https://pub.dev/packages/intl) | Date and number formatting (e.g. certificate issue dates). |
| [`uuid`](https://pub.dev/packages/uuid) | Unique identifier generation for mock/local data. |
| [`smooth_page_indicator`](https://pub.dev/packages/smooth_page_indicator) | Dot/page indicators, used in onboarding. |
| [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) | iOS-style icon set. |
| [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) *(dev tool)* | Generates Android/iOS app icons from a single source image. |
| [`flutter_lints`](https://pub.dev/packages/flutter_lints) *(dev)* | Recommended lint rules for Flutter projects. |
| [`flutter_test`](https://docs.flutter.dev/testing) *(dev)* | Flutter's widget/unit testing framework. |

## Setup instructions

**Prerequisites**

- Flutter SDK compatible with `^3.12.2` (run `flutter --version` to check)
- A configured Android/iOS toolchain (Android Studio / Xcode) or a connected device/emulator
- Git

**1. Clone the repository**

```bash
git clone <repository-url>
cd praktix
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Generate app launcher icons** (only needed after changing `assets/images/logo.webp` or the `flutter_launcher_icons` config in `pubspec.yaml`)

```bash
flutter pub run flutter_launcher_icons
```

**4. Run the app**

```bash
flutter run
```

To target a specific platform:

```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

**5. Run tests**

```bash
flutter test
```

**6. Build a release**

```bash
flutter build apk        # Android
flutter build ios        # iOS
```

> Note: this MVP currently runs on mock data sources under `lib/data/`. Swap in real API integrations behind the existing repository contracts in `lib/domain/` when backend endpoints are available.
