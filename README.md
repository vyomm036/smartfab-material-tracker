# SmartFab Industries - Material Tracking & Costing App

A comprehensive Flutter application for SmartFab Industries to track materials, manage costs, and streamline manufacturing processes.

## Features

- Material tracking and inventory management
- Cost calculation and analysis
- Real-time synchronization
- Offline capabilities
- User authentication and role-based access
- Analytics and reporting

## Project Structure

```
lib/
  ├── config/              # App configuration
  ├── core/                # Core utilities and constants
  ├── data/                # Data layer
  │   ├── models/          # Data models
  │   ├── repositories/    # Repository implementations
  │   └── sources/         # Data sources (local and remote)
  ├── domain/              # Business logic
  │   ├── entities/        # Business entities
  │   ├── repositories/    # Repository interfaces
  │   └── usecases/        # Use cases
  ├── presentation/        # UI layer
  │   ├── screens/         # App screens
  │   ├── widgets/         # Reusable widgets
  │   └── blocs/           # State management
  ├── services/            # Service implementations
  └── main.dart            # Entry point
```

## Getting Started

1. Clone the repository
2. Install Flutter SDK (if not already installed)
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Dependencies

- Flutter Bloc for state management
- SQFlite for local database
- Dio for network requests
- Shared Preferences for local storage
- Various UI and utility packages

## Development Guidelines

- Follow Clean Architecture principles
- Use BLoC pattern for state management
- Write unit tests for business logic
- Follow Material Design guidelines
- Maintain consistent code style

## License

This project is proprietary software owned by SmartFab Industries.
 