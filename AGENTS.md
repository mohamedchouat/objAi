# Objai - Flutter AI Object Recognition App

## Commands
- **Run**: `flutter run`
- **Build**: `flutter build apk` / `flutter build ios`
- **Analyze**: `flutter analyze`
- **Test all**: `flutter test`
- **Single test**: `flutter test test/<file>_test.dart`
- **Code gen** (Hive): `flutter pub run build_runner build --delete-conflicting-outputs`

## Architecture (Clean Architecture)
- `lib/core/` - Utilities, storage helpers
- `lib/data/` - Models, datasources, repositories (Hive for local DB)
- `lib/domain/` - Business entities
- `lib/presentation/` - Screens, UI, Riverpod providers

## Code Style
- State management: **Riverpod** (`flutter_riverpod`)
- Local storage: **Hive** (models use `@HiveType`, `@HiveField` annotations)
- HTTP: **Dio**
- Generated files: `*.g.dart` - Do NOT edit, regenerate with build_runner
- Imports: Dart SDK first, then packages, then relative imports
- Naming: camelCase for variables/methods, PascalCase for classes/types
