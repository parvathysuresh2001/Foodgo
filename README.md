# Foodgo

Foodgo is a food delivery mobile application built with Flutter. This repository contains the client-side app, covering the splash screen, authentication flow, and home experience, wired up to a REST API backend.

## Features

- **Login** — email/password authentication against a live REST API, with token storage, loading states, and inline error handling.
- **Home** — landing screen shown after a successful login.
- **Custom App Icon & Branding** — Foodgo-branded launcher icon generated to match the app's color palette.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) (Dart) |
| Language | Dart (SDK `^3.11.4`) |
| Networking | [`http`](https://pub.dev/packages/http) — REST API calls |
| Local Storage | [`shared_preferences`](https://pub.dev/packages/shared_preferences) — persisting auth tokens |
| Vector Assets | [`flutter_svg`](https://pub.dev/packages/flutter_svg) |
| Icons | [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) |
| App Icon Generation | [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) |
| Linting | [`flutter_lints`](https://pub.dev/packages/flutter_lints) |
| Backend | REST API — `https://api.gulika.app` |

### Supported Platforms

This project builds for Android, iOS, Web, and Windows desktop (as configured by the standard Flutter project structure).

## Project Structure

```
foodgo/
├── android/                # Android platform project
├── ios/                    # iOS platform project
├── assets/                 # Images, icons, and other static assets
├── lib/
│   ├── main.dart           # App entry point & route definitions
│   ├── login_screen.dart   # Login screen + API integration
│   └── ...                 # Additional screens
├── pubspec.yaml            # Project metadata & dependencies
└── README.md
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured (`flutter doctor` should show no blocking issues)
- A code editor — [VS Code](https://code.visualstudio.com/) with the Flutter extension, or Android Studio
- For Android builds: Android SDK + a device/emulator, or a physical device with **Developer Mode/USB debugging** enabled
- For Windows desktop builds: **Developer Mode** enabled in Windows Settings (required for plugin symlink support)

### 1. Clone / open the project

```bash
cd foodgo
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate the app icon (first time / after changing `assets/app_icon.png`)

```bash
flutter pub run flutter_launcher_icons
```

### 4. Run the app in debug mode

```bash
flutter run
```

You'll be prompted to choose a target device (Windows, Chrome, Edge, a connected Android device, etc.) if more than one is available.

To run directly on a specific platform:

```bash
flutter run -d chrome     # Web (Chrome)
flutter run -d windows    # Windows desktop
flutter run -d <device-id>  # Android/iOS device or emulator
```

Use `flutter devices` to list available targets.

## Building for Release

### Android (APK)

```bash
flutter clean
flutter build apk --release
```

The generated APK will be located at:

```
build/app/outputs/flutter-apk/app-release.apk
```

Transfer this file to an Android device and install it (enable "Install from unknown sources" if prompted).

### Android (App Bundle — for Play Store)

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

(Requires a Mac with Xcode installed, and a valid Apple signing configuration.)

### Web

```bash
flutter build web --release
```

Output is generated in `build/web/`.

### Windows Desktop

```bash
flutter build windows --release
```

## Configuration

### API Endpoint

The login screen calls the following endpoint:

```
POST https://your-endpoint
```
replace your endpoint with actual end point URL

This is configured in `lib/login_screen.dart` via the `_loginUrl` constant. Update this value if pointing to a different environment (staging, local, etc.).

### App Name

The Android display name is set via `android:label` in `android/app/src/main/AndroidManifest.xml`.

### App Icon

The launcher icon source image lives at `assets/app_icon.png`. After replacing it, regenerate all platform icon sizes with:

```bash
flutter pub run flutter_launcher_icons
```

## Troubleshooting

| Issue | Likely Cause | Fix |
|---|---|---|
| `A dependency may only have one source` (pubspec error) | Incorrect YAML indentation under `dependencies:` | Ensure each package key is indented consistently at the same level, not nested under another package |
| Windows build fails with a symlink error | Developer Mode not enabled | Run `start ms-settings:developers` and enable Developer Mode, then reopen the terminal |
| "Could not connect to the server" only in Chrome, works elsewhere | CORS restrictions on web | Check Chrome DevTools console for a CORS error; needs a backend-side fix |
| "Could not connect to the server" only in the built APK | Missing Android internet permission | Ensure `<uses-permission android:name="android.permission.INTERNET"/>` is present in `AndroidManifest.xml`, then `flutter clean` and rebuild |

## License

Private project — not published to pub.dev (see `publish_to: 'none'` in `pubspec.yaml`).