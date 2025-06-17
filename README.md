# 🐾 FlutterPaws Pet Management 🐾

[中文](README_CN.md) | EN

<p align="center">
  <img src="./assets/logo.png" alt="FlutterPaws Logo" width="45%" />
</p>

<div align="center">
  
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-4285F4?style=for-the-badge&logo=google&logoColor=white)
![shared_preferences](https://img.shields.io/badge/shared_preferences-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)
![Cupertino](https://img.shields.io/badge/Cupertino-000000?style=for-the-badge&logo=apple&logoColor=white)
![Font Awesome](https://img.shields.io/badge/Font%20Awesome-4285F4?style=for-the-badge&logo=font-awesome&logoColor=white)
  
</div>

<div align="center">
  
![MIT License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=flat-square)
![GitHub Stars](https://img.shields.io/github/stars/Echo-Nie/FlutterPaws?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Echo-Nie/FlutterPaws?style=social)

</div>



## 📖 Project Overview
FlutterPaws is a full-platform pet diary application developed using the Flutter framework. This application is designed specifically for pet owners, providing modules such as diary recording, schedule management, health tracking, and photo gallery, offering a complete solution for managing pet life.

## 🌟 Core Features

#### 📝 Intelligent Diary System
- Multimedia Support: Supports combinations of text, images, and videos to record various scenarios
- Auto Tagging: Automatically generates time and type tags, supports custom tags and categories
- Mood Tracking: Includes an emoji selector (e.g., 😄 Happy, 😴 Sleepy, 🍖 Hungry)
- Template System: Pre-set templates for growth records, health updates, and memorable moments

#### 📅 Pet Schedule Management
- Triple Reminder System: Feeding (timed/recurring), Vaccinations (due reminders), Grooming (cycle reminders)
- Custom Events: Supports recurring cycles (e.g., weekly deworming, monthly baths)
- Colorful Calendar: Intuitively displays event priority through color coding

#### 🏥 Health Data Management
- Weight Tracking: Interactive charts supporting week/month/year comparisons
- Vaccine Panel: Countdown for rabies, infectious diseases, etc.
- Medication Reminders: Dose calculation based on pet weight (e.g., weight × 2mg/kg)
- Quarterly Health Reports: Automatically generates BMI analysis and vaccine expiration tracking

## 🐾 Pet Management Application Prototype (MasterGo)

 - **Points Redemption 🛒:** Displays current points balance. "View Details" button to check transaction history. List of redeemable items including dog food, snacks, beds, and water bottles.
 - **Home 🏠:** Displays pet profiles including photos, age, breed, and weight. Quick access panel: daily check-in, health tracking, weight records, notes, and feeding guidelines. Community interaction sections for following and recommendations.
 - **Weight Tracking 📊:** Graphical display of weight data over time (line chart). Time range selector (week view, month view, year view). Shows highest and lowest recorded weights.
 - **User Profile 👤:** User information including avatar, nickname, likes, followers, and followings. Registered pets list. Settings options: theme selection, language preference, and logout.
 - **Calendar Records 📅:** Calendar-based interface with activity markers. Recording functions include bathing, walking, weight records, etc. Medical record section includes hospital name, diagnosis, and description.

![image](https://github.com/user-attachments/assets/5fc24d68-b51c-4824-833b-86f62610c3b8)

## 💻 Technical Architecture

#### Core Technology Stack

| Component                      | Version  | Description                       |
| -------------------------------| -------- | ----------------------------------|
| **Flutter**                    | 3.7.0    | Cross-platform UI framework       |
| **Dart**                       | 3.0.0    | Null-safe programming language    |
| **Provider**                   | 6.1.2    | State management for themes, languages, and data |
| **SharedPreferences**          | 2.2.2    | Lightweight local data persistence |
| **Flutter Localizations**      | -        | Multilingual support system       |
| **Cupertino Icons**            | 1.0.8    | iOS-style icon library            |

#### Key Technical Features
1. **Responsive Design**: Uses `LayoutBuilder` to achieve adaptive layouts, ensuring consistent experience across phones, tablets, and web
2. **Hybrid Integration**: Implements native system interactions (local notifications, album access) via `platform_channel`
3. **Performance Optimization**: Uses `ListView.builder` for virtualized rendering of large lists

## 📦 Project Structure

```
lib/
├── core/              # Core functionalities
│   ├── models/        # Data models (Pet.dart, Diary.dart, HealthRecord.dart)
│   ├── services/      # Business logic (NotificationService, HealthService)
│   └── utils/         # Utility classes (DateUtil, ImageUtil, ThemeUtil)
├── presentation/      # UI layer
│   ├── pages/         # Main pages
│   │   ├── HomePage.dart       # Dashboard with diary timeline and quick actions
│   │   ├── CalendarPage.dart   # Schedule visualization
│   │   ├── HealthPage.dart     # Health metrics dashboard
│   ├── widgets/       # Reusable components
│   │   ├── PetCard.dart        # Pet profile with status indicators
│   │   ├── DiaryItem.dart      # Diary entry with media preview
│   │   └── ReminderTile.dart   # Reminder component with countdown
├── config/            # Configuration
│   ├── themes/        # Theme settings (light/dark mode)
│   └── locales/       # Localization resources (Chinese/English)
└── main.dart          # Application entry point
```

## 🚀 Quick Start

1. Install [Flutter 3.7.0+](https://flutter.dev/docs/get-started/install)
2. Set up IDE: Install Android Studio/VS Code with Flutter plugin
3. Verify setup using `flutter doctor`

```
# Clone repository
git clone https://github.com/Echo-Nie/FlutterPaws.git
cd FlutterPaws
```

```
# Install dependencies
flutter pub get
```

```
# Run on default device
flutter run
```

```
# Build Android release APK
flutter build apk --release
```

```
# Build iOS release IPA
flutter build ios --release
```

## 🔮 Future Enhancements
- [ ] **Pet Social Network**: Community feed and location-based owner matching
- [ ] **AI Health Analysis**: Image recognition for pet emotion detection and predictive analytics
- [ ] **Cloud Sync**: Multi-device sync based on Firebase, supporting family account sharing

## 📄 License
This project is released under the MIT open-source license. Commercial use or derivative works require authorization from the author.

> 🌟 If you find this project useful, please give it a ⭐️! Your support is the driving force behind continuous improvements.

## 🙏 Acknowledgments
Special thanks to the Flutter team for providing the cross-platform framework, and to the developers of open-source libraries like Provider and SharedPreferences. Also, thank you to the course instructors for their guidance and feedback during development.

## 📞 Contact
- GitHub Issues: [Report Issues/Request Features](https://github.com/Echo-Nie/FlutterPaws/issues)
- Email: [nyxchaoji123@163.com](mailto:nyxchaoji123@163.com)
