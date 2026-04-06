# 🍽️ NutriSnap

**AI-powered food tracking** — Snap a photo of your meal and instantly get nutritional data, personalised meal plans, and insightful reporting dashboards.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase)
![Gemini](https://img.shields.io/badge/Gemini_AI-2.5_Flash-4285F4?logo=google)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

- 📸 **Photo Food Recognition** — Take a photo, AI identifies foods and portions
- 🔢 **Instant Nutrition Data** — Calories, protein, carbs, fat via USDA database
- 📊 **Smart Dashboard** — Daily/weekly/monthly charts and progress tracking
- 🍱 **AI Meal Planning** — Personalised weekly plans powered by Gemini
- 🛒 **Grocery Lists** — Auto-generated from your meal plan
- 💧 **Water Tracking** — Stay hydrated with reminders
- 🏆 **Gamification** — Streaks, badges, and XP to keep you motivated
- 📱 **Barcode Scanner** — Scan packaged foods for instant lookup

## 🏗️ Architecture

```
Flutter App (Dart)
  ├── Riverpod (State Management)
  ├── GoRouter (Navigation)
  └── fl_chart (Visualisation)

Firebase Backend
  ├── Authentication
  ├── Cloud Firestore
  ├── Cloud Storage
  └── Cloud Functions v2 (Node.js/TS)

AI Services
  ├── Google Cloud Vision API
  ├── Gemini 2.5 Flash
  └── USDA FoodData Central
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.x
- Dart SDK 3.x
- Firebase CLI
- Node.js 20+ (for Cloud Functions)

### Setup

```bash
# Clone the repository
git clone https://github.com/tomramsay/nutrisnap.git
cd nutrisnap

# Install dependencies
flutter pub get

# Set up Firebase (requires FlutterFire CLI)
flutterfire configure

# Run the app
flutter run
```

### Cloud Functions

```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

## 📂 Project Structure

```
lib/
├── core/           # Theme, router, constants, utils
├── features/       # Feature modules (auth, meal_log, dashboard, etc.)
│   └── <feature>/
│       ├── data/           # Repositories, services
│       ├── domain/         # Models (Freezed)
│       └── presentation/   # Screens, widgets, controllers
├── shared/         # Shared widgets and providers
└── l10n/           # Localisation
```

## 🧪 Testing

```bash
# Unit & widget tests
flutter test

# Integration tests
flutter test integration_test

# Cloud Functions tests
cd functions && npm test
```

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
