📱 Knovator Flutter Particle Task

A simple Flutter application built as part of the Knovator assignment.
It fetches posts from a public API, supports local persistence with Hive, marks posts as read, and uses BLoC for clean state management.

🚀 Features

✅ Fetches posts from JSONPlaceholder API

✅ Displays list of posts with light yellow background for unread items
✅ When tapped, opens a detail screen showing the post body
✅ Marks tapped posts as read (background turns white)
✅ Caches data locally using Hive — loads from cache on next app start
✅ Performs background sync with the API
✅ Implements BLoC pattern for maintainable state management
✅ Proper error & loading handling

🧩 Tech Stack
Category	Library
State Management	flutter_bloc
Networking	http
Local Storage	hive + hive_flutter
Utility	path_provider, equatable
🏗️ Project Structure
lib/
├── main.dart
├── core/
│    ├── api_client.dart
│    ├── hive_service.dart
├── data/
│    ├── models/
│    │    └── post_model.dart
│    ├── repository/
│         └── post_repository.dart
├── logic/
│    └── bloc/
│         ├── post_bloc.dart
│         ├── post_event.dart
│         └── post_state.dart
└── presentation/
├── screens/
│    ├── post_list_screen.dart
│    └── post_detail_screen.dart
└── widgets/
└── post_item.dart

⚙️ Setup Instructions

Clone or download this repository

git clone <your_repo_url>
cd flutter_knovator_task


Install dependencies

flutter pub get


Run the app

flutter run


If you face Hive issues, make sure to clean and rebuild:

flutter clean
flutter pub get
flutter run

📦 Build APK

To generate a release APK:

flutter build apk --release


The output file will be located at:

build/app/outputs/flutter-apk/app-release.apk

🧠 Architecture Notes

BLoC pattern ensures clear separation between business logic and UI.

Repository layer abstracts both API and local storage.

Hive local cache stores posts and read IDs.

The app shows cached data first, then silently updates in the background.

🧪 Error Handling

Shows a friendly message and a Retry button when network requests fail.

Background sync failures do not interrupt the user flow.

📹 Submission Checklist

✅ Working APK file
✅ Public GitHub repository
✅ Short demo video (screen recording)
✅ This README file