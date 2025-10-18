# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SUTUTEH App is a Flutter mobile application for the SUTUTEH union (Sindicato Único de Trabajadores Universitarios del Tecnológico de Estudios de Huejutla). Currently at v1.0.0 with basic functionality including authentication, QR scanning, notifications, and profile management.

## Development Commands

### Setup and Dependencies
```bash
# Install Flutter dependencies
flutter pub get

# Check for outdated packages
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade
```

### Running the App
```bash
# Run on connected device/emulator (debug mode)
flutter run

# Run on specific device
flutter devices                    # List available devices
flutter run -d <device-id>         # Run on specific device

# Run with hot reload enabled (default in debug)
flutter run --hot
```

### Code Quality
```bash
# Run linter (uses flutter_lints rules)
flutter analyze

# Format all Dart files
dart format .

# Format specific file
dart format lib/path/to/file.dart
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Building
```bash
# Build APK (Android)
flutter build apk

# Build APK in release mode with split per ABI
flutter build apk --split-per-abi

# Build App Bundle (for Play Store)
flutter build appbundle

# Build for iOS (requires macOS)
flutter build ios

# Build for Windows
flutter build windows
```

### Cleaning
```bash
# Clean build artifacts
flutter clean

# Rebuild after clean
flutter clean && flutter pub get
```

## Architecture Overview

### Project Structure

The codebase follows a **modular/feature-based architecture** with local state management:

```
lib/
├── main.dart                          # Entry point, MaterialApp config, SplashWrapper
└── modulos/                           # Feature modules (organized by domain)
    ├── autenticacion/paginas/         # Login, password recovery
    ├── carga/paginas/                 # Splash screen with custom arc animation
    ├── escaner/paginas/               # QR code scanner (mobile_scanner)
    ├── inicio/paginas/                # Main hub with 3-tab navigation + drawer
    ├── notificaciones/paginas/        # Notifications list view
    ├── perfil/paginas/                # Profile summary, personal data display
    └── informacion/paginas/           # Help, About pages
```

### State Management

- **No global state management library** (no Provider, BLoC, Riverpod, etc.)
- **Local state only**: StatefulWidget with `setState()` for UI updates
- State variables are scoped to individual pages (e.g., `_showPassword`, `_index`, `_controller`)

### Navigation Pattern

- **Direct imperative navigation** using `Navigator.push()` and `Navigator.pushReplacement()`
- **No named routes** configured
- Flow: `SplashWrapper` (15s) → `LoginPagina` → `InicioPagina` (main hub with tabs + drawer)

### Key Application Flow

1. **App Launch**: `main.dart` → `SplashWrapper` displays `CargaPagina` for 15 seconds
2. **Authentication**: Automatic navigation to `LoginPagina` with email/password validation
3. **Main Hub**: `InicioPagina` serves as the central screen with:
   - 3-tab bottom navigation: Home, QR Scanner, Notifications
   - Drawer menu for Profile, Help, About, Logout
   - Animated green indicator bar for tab transitions

### UI/Design System

- **Dark theme** with consistent color palette:
  - Backgrounds: `#121212`, `#1E2939`, `#0F0F0F`
  - Primary (institutional): `#4CAF50` (Green)
  - Accents: `#64B5F6` (Blue), `#E57373` (Red), `#FFB74D` (Orange)
- **Material Design** components with custom styling
- **BorderRadius**: 12-16px for consistency
- **BoxShadow**: Used for depth on cards and containers

### External Dependencies

- **mobile_scanner** (^3.5.6): QR/barcode scanning functionality
- **url_launcher** (^6.3.0): Opening external URLs (e.g., sututeh.com)
- **flutter_lints** (^5.0.0): Code analysis with recommended Flutter lints

### Current Limitations (as of v1.0.0)

- All data is **hardcoded** (notifications, personal data) - no API integration
- No **backend service layer** or data models
- No **testing coverage** beyond default widget_test.dart
- **QR scanner** shows placeholder SnackBar (no actual backend processing)
- **Authentication** validates format only (no real auth service)

## Flutter Version

- **Flutter**: 3.35.4 (stable channel)
- **Dart**: 3.9.2
- **DevTools**: 2.48.0
- **Minimum SDK**: ^3.9.2 (from pubspec.yaml)

## Assets

Images are stored in `assets/imagenes/`:
- `logoSth.png` - Union logo (used in splash and login)
- `perfil.webp`, `perfil2.jpeg` - Profile pictures
- `p.jpg` - Main page decorative image

Ensure new assets are registered in `pubspec.yaml` under `flutter: assets:`.

## Working with Features

When adding new features:

1. **Create module structure**: `lib/modulos/<feature_name>/paginas/`
2. **Follow naming convention**: `<feature>_pagina.dart` for page files
3. **Use StatefulWidget** for interactive pages, StatelessWidget for static content
4. **Import navigation**: Use MaterialPageRoute for navigation between pages
5. **Match design system**: Use consistent dark theme colors and Material components
6. **Update drawer menu** in `inicio_pagina.dart` if adding new top-level sections

## Code Style Notes

- **File naming**: snake_case for Dart files (e.g., `login_pagina.dart`)
- **Class naming**: PascalCase for widgets (e.g., `LoginPagina`)
- **Private members**: Prefix with underscore (e.g., `_showPassword`, `_buildCard()`)
- **Emojis in comments**: Currently used in code comments (e.g., `// 👈 comment`)
- **String literals**: Mix of single and double quotes (no enforced preference)
- **Linting**: Follows `package:flutter_lints/flutter.yaml` rules

## Git Workflow

- **Main branch**: Not yet configured (check with team)
- **Current branch**: `feature/ui-design` (as of last commit)
- **Recent commits**:
  - `ebae28a` - SCRUM-21: UI improvements and layout updates (v0.2.0)
  - `47d3454` - Bootstrap Flutter app (v0.1.0)
