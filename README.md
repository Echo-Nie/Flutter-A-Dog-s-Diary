# 🐾 FlutterPaws Pet Management 🐾

EN | [中文](README_zh.md)

<p align="center">
  <img src="./assets/logo.png" alt="FlutterPaws Logo" width="45%" />
</p>

# FlutterPaws

A modern pet management application built with Flutter, designed to help pet owners better care for their beloved companions.

## Features

- Pet Profile Management
- Health Records
- Weight Tracking
- Calendar Reminders
- Topic Discussion
- Multi-language Support
- Dark Mode Support
- Pet Breed Recognition

## Pet Breed Recognition

The application provides pet breed recognition functionality, using TensorFlow Lite models to identify different breeds of pets.

### How to Configure Pet Breed Recognition

1. Place the following files in the assets directory:
   - `model_unquant.tflite`: TensorFlow Lite model file
   - `labels.txt`: Label file containing names of recognized pet breeds

2. Model retrieval:
   - Can be downloaded from TensorFlow Hub
   - Or use a self-trained TensorFlow model and convert it to TFLite format

Detailed configuration instructions can be found in: [assets/README.md](assets/README.md)

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.0)
- Dart SDK
- Android Studio / VS Code with Flutter plugin

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/my_first_flutter.git
```

2. Navigate to project directory
```bash
cd my_first_flutter
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Dependencies

- cupertino_icons: ^1.0.8
- shared_preferences: ^2.2.2
- provider: ^6.1.2
- speech_to_text: ^6.5.1
- flutter_localizations

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
