# Spirit of Hope — Mobile App

Flutter app (Android and iOS) for **Spirit of Hope Home Health Care**, a non-medical
in-home care agency serving Howard, Anne Arundel, Montgomery and Baltimore counties
in Maryland. It is a companion to the website, [spiritofhopes.com](https://www.spiritofhopes.com).

Planned features:

1. Home safety assessment
2. Free consultation booking
3. Blog (articles published on the website)
4. AI support assistant (chat)

There are no user accounts — every feature works anonymously.

Project conventions, design tokens and accessibility requirements are in
[`CLAUDE.md`](CLAUDE.md). Read it before contributing.

## Backend

**There is no local backend to start.** The backend is the existing Wix Velo site.
The app calls HTTP functions on it:

- Production: `https://www.spiritofhopes.com/_functions`
- Preview: `https://www.spiritofhopes.com/_functions-dev`

Velo source lives in [`wix-backend/`](wix-backend/). It is kept here for version
control and copy-pasted into the Wix editor; it is not compiled or run from this repo.

## Requirements

- Flutter stable (developed against 3.47.7 / Dart 3.13.5)
- Android Studio with an Android emulator, and/or Xcode with an iOS simulator (macOS only)

Check your setup with:

```sh
flutter doctor
```

## Running

```sh
flutter pub get
flutter devices          # list available emulators/simulators
flutter run              # run on the selected device
flutter run -d <id>      # run on a specific device
```

Before committing:

```sh
flutter analyze          # must report zero issues
```

## Project layout

```
lib/
  main.dart
  app.dart                 # MaterialApp, theme, routing
  core/                    # theme, api client, models, utils
  features/                # home, blog, assessment, booking, chat
  shared/widgets/          # shared UI components
wix-backend/               # Velo source (copy-pasted into Wix)
```
