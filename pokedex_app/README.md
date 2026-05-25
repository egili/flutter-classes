# pokedex_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



lib/trainer_profile_screen.dart:29:17: Error: The getter 'FirebaseAuth' isn't defined for the type '_TrainerProfileScreenState'.
 - '_TrainerProfileScreenState' is from 'package:pokedex_app/trainer_profile_screen.dart' ('lib/trainer_profile_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'FirebaseAuth'.
    final uid = FirebaseAuth.instance.currentUser?.uid;
                ^^^^^^^^^^^^
lib/trainer_profile_screen.dart:49:17: Error: The getter 'FirebaseAuth' isn't defined for the type '_TrainerProfileScreenState'.
 - '_TrainerProfileScreenState' is from 'package:pokedex_app/trainer_profile_screen.dart' ('lib/trainer_profile_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'FirebaseAuth'.
    final uid = FirebaseAuth.instance.currentUser?.uid;