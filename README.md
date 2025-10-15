# 📱 Knovator Flutter Particle Task

A Flutter application developed for the **Knovator assignment**.  
The app fetches posts from a public API, supports local caching, and demonstrates proper architecture using **BLoC**, **Hive**, and **http**.

---

## ✨ Features

- 🟡 Displays posts with a **light yellow background** for unread items
- ⚪ Changes to **white background** once marked as read
- 📄 Opens a **detail screen** showing post description (`body`)
- 🔁 **Local persistence** using Hive (loads cached data first)
- 🌐 Background API synchronization for updated data
- ⚙️ Uses **BLoC pattern** for state management
- 🚨 Handles loading & error states gracefully

---

## 🧰 Tech Stack

| Category | Library |
|-----------|----------|
| State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) |
| Networking | [http](https://pub.dev/packages/http) |
| Local Storage | [hive](https://pub.dev/packages/hive), [hive_flutter](https://pub.dev/packages/hive_flutter) |
| Utility | [path_provider](https://pub.dev/packages/path_provider), [equatable](https://pub.dev/packages/equatable) |

---

## 🏗️ Project Structure

lib/
├── main.dart
├── core/
│ ├── api_client.dart
│ ├── hive_service.dart
├── data/
│ ├── models/post_model.dart
│ ├── repository/post_repository.dart
├── logic/
│ └── bloc/
│ ├── post_bloc.dart
│ ├── post_event.dart
│ └── post_state.dart
└── presentation/
├── screens/
│ ├── post_list_screen.dart
│ └── post_detail_screen.dart
└── widgets/
└── post_item.dart


---

## ⚙️ Setup Instructions

1. **Clone this repository**
   ```bash
   git clone <your_repo_url>
   cd flutter_knovator_task

2. **Install dependencies**
    ```bash
   flutter pub get

3. **Run the app**
    ```bash
   flutter run
   
4. **If you face any issues with Hive, clean and rebuild:**
    ```bash
   flutter clean
   flutter pub get
   flutter run

## 📦 Build Release APK

To generate a release APK:
    ```bash
    flutter build apk --release

Find it at:
    ```swift
    build/app/outputs/flutter-apk/app-release.apk
