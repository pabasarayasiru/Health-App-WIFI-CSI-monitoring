# frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



file structure
lib/
│
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   └── websocket_service.dart
│   └── utils/
│       └── helpers.dart
│
├── features/
│   ├── realtime/
│   │   ├── models/
│   │   │   └── health_live_model.dart
│   │   ├── services/
│   │   │   └── realtime_service.dart
│   │   ├── providers/
│   │   │   └── realtime_provider.dart
│   │   └── screens/
│   │       └── realtime_screen.dart
│   │
│   ├── history/
│   │   ├── models/
│   │   │   └── health_history_model.dart
│   │   ├── services/
│   │   │   └── history_service.dart
│   │   ├── providers/
│   │   │   └── history_provider.dart
│   │   └── screens/
│   │       └── history_screen.dart
│
├── shared/
│   ├── widgets/
│   │   ├── health_card.dart
│   │   └── loading_widget.dart
│
└── main.dart