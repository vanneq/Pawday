# Pawday

Pawday is a Flutter mobile app for keeping a personal pet diary. The app lets users add one or more cats, choose each cat's coloration and personality, track how many days they have spent together, and save diary entries with a mood, description, and photo

## Features

- Email/password sign up and sign in with Firebase Authentication.
- Add, edit, and delete cat profiles.
- Choose a cat coloration
- Choose a cat personality
- Main screen with the selected cat, days-together counter, and quick diary entry creation
- Diary entries for the selected cat.
- Filter diary entries by mood.
- Create, view, edit, and delete diary entries
- Upload photos to diary entries with image compression.
- Store app data in Cloud Firestore and photos in Firebase Storage.


## Tech Stack

- Flutter / Dart
- Firebase Core, Firebase Auth, Cloud Firestore, Firebase Storage
- `flutter_bloc` for screen state management
- `flutter_riverpod` for app-level providers and router setup
- `get_it` for dependency injection
- `go_router` for navigation
- `freezed` and `json_serializable` for models and states
- `image_picker` and `flutter_image_compress` for image handling
- `google_fonts`, `dotted_border`, Material/Cupertino widgets

## Project Structure

```text
lib/
  core/
    app/                 # app setup, theme, color scheme, and typography
    di/                  # dependency registration with get_it
    model/               # user, cat, and diary entry models
    navigation/          # bottom navigation
    providers/           # shared Riverpod providers
    router/              # go_router routes
    widgets/             # reusable widgets
  features/
    auth/                # authentication
    main/                # main screen and cat list state
    profile/             # profile, add cat, and edit cat screens
    dairy/               # pet diary feature
    splash/              # splash screen
assets/
  cats/                  # cat images used for coloration selection
```

## Routes

- `/splash` - initial screen while the authentication state is loading.
- `/login` and `/register` - sign in and sign up.
- `/main` - main screen for the selected cat.
- `/diary` - diary entry list.
- `/profile` - profile screen and cat list.
- `/profile/add_cat` - add a cat.
- `/profile/edit_cat` - edit a cat.
- `/diary/add_entry` - create a diary entry.
- `/diary/entry` - diary entry details.
- `/diary/edit_entry` - edit a diary entry.

## Firebase

The project uses Firebase for authentication, database storage, and image storage. Firebase configuration is loaded from `lib/firebase_options.dart`.

Before running the app, make sure your Firebase project has:

- Authentication enabled with the Email/Password provider;
- Cloud Firestore enabled;
- Firebase Storage enabled;
- platform configuration files for Android and iOS.

To regenerate Firebase configuration, use the FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

## Getting Started

1. Install dependencies:

```bash
flutter pub get
```

2. Generate model and state files if they are missing or were changed:

```bash
dart run build_runner build --delete-conflicting-outputs
```

3. Run the app:

```bash
flutter run
```

## Useful Commands

```bash
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
```

## Data Model

User data is stored in Firestore with the following structure:

```text
users/{userId}/cats/{catId}
users/{userId}/cats/{catId}/entries/{entryId}
```

Diary entry photos are uploaded to Firebase Storage:

```text
diary/{userId}/{catId}/{timestamp}.jpg
```

