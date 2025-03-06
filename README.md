# Tord

A Flutter application that brings the classic “Truth or Dare” game to your mobile and web devices. With a clean UI, multiple game modes, and support for multiple languages, this app is a great starting point for developers and anyone who wants to add a bit of fun to their day!

## Features

- **Multi-Platform Support:** Runs on Android, iOS, and web.
- **Multiple Game Modes:**  
  - **Splash Screen:** Greets users upon opening.  
  - **Menu & Navigation:** Easily switch between different game modes.  
  - **Challenge Screens:** Truth, dare, and other interactive challenges.  
  - **Scratcher & Spinning Screens:** Fun mechanics for unique gameplay.
- **Localization:** Supports English (`en_US`), Persian (`fa`), and Turkish (`tr`) via `flutter_translate`.
- **Error Reporting:** Integrated with Firebase Crashlytics for real-time crash reporting.
- **Theming:** Light and dark theme support, with a playful font (“Kalam”).

## Project Structure

tord/ <br>
├── android/-------------------# Android-specific configuration<br>
├── ios/------------------------# iOS-specific configuration<br>
├── lib/-------------------------# Dart source code<br>
│-------├── models/------------# App state and data models (e.g., PlayerData)<br>
│-------├── screens/------------# UI screens (splash, menu, game, etc.)<br>
│-------└── main.dart-----------# Main entry point for the Flutter app<br>
├── web/------------------------# Web-specific configuration<br>
├── assets/---------------------# Images and other assets<br>
├── test/------------------------# Unit and widget tests<br>
├── pubspec.yaml---------------# Project configuration and dependencies<br>
└── README.md---------------# This file<br>


## Running the App

1. **Clone the repository:**
    ```bash
    git clone https://github.com/dranoer/tord.git
    cd tord
    ```
2. **Install dependencies:**
    ```bash
    flutter pub get
    ```
3. **Run on your device or emulator:**
    ```bash
    flutter run
    ```
    *For web, use:*  
    ```bash
    flutter run -d chrome
    ```

## Dependencies

- [provider](https://pub.dev/packages/provider) – State management
- [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) – Localization support
- [flutter_translate](https://pub.dev/packages/flutter_translate) – Multi-language setup
- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) – Crash reporting

## Contributing

Contributions are welcome! Feel free to:

- Open issues for bug reports or feature requests.
- Fork this repository and submit pull requests with improvements.
- Improve documentation and add examples.

## Contact

For questions, suggestions, or feedback, please [contact me](mailto:dranoer@gmail.com) by Email.

