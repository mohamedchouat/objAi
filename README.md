# 📸 ObjAI Scanner

## 📷 Screenshots

| Home Screen | Details Screen |
|-------------|----------------|
| ![Home](https://github.com/mohamedchouat/objAi/blob/main/screen/home.jpg) | ![Details](https://github.com/mohamedchouat/objAi/blob/main/screen/details.jpg) |

ObjAI Scanner is a modern **Flutter application** designed to identify real-world objects using **Clarifai Vision AI**, then fetch educational facts from **Wikipedia**, and store the result locally using **Hive**.

The project is built as a **Clean Architecture** example using **Riverpod** for scalable, testable state management.

---

## ✨ Features

- **AI Object Identification**  
  Capture an image (camera or gallery) and send it to Clarifai to detect the primary object.

- **Knowledge Retrieval**  
  Fetch a structured summary, facts, and an image from the Wikipedia API.

- **Local History (Hive)**  
  All scans — including original image paths and extracted facts — are saved and persist locally.

- **Local File Storage**  
  Saves the original image to the app documents directory.

- **Clean Architecture**  
  Strict separation into **Domain**, **Data**, and **Presentation** layers.

- **Riverpod State Management**  
  Compile-time safe and scalable.

---

## 🏗️ Tech Stack

| Category | Technology | Purpose |
|---------|------------|---------|
| Language | **Dart / Flutter** | Cross-platform mobile app |
| Architecture | Clean Architecture, Repository Pattern | Scalability & testability |
| State Management | **Riverpod** | Robust & compile-time safe |
| Local Storage | **Hive + hive_flutter** | Fast NoSQL persistence |
| Networking | **dio** | API calls (Clarifai + Wikipedia) |
| Utilities | image_picker, uuid, path_provider | Image selection & file handling |

---

## 🧩 Architecture

```
lib/
├── core/
│   ├── storage_helper.dart
│   └── utils.dart
├── data/
│   ├── datasources/
│   │   ├── local_datasource.dart
│   │   ├── vision_datasource.dart
│   │   └── wiki_datasource.dart
│   ├── models/
│   │   ├── scan_model.dart
│   │   ├── scan_model.g.dart
│   │   └── wiki_result.dart
│   └── repositories/
│       └── scan_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── scan_entity.dart
│   └── repositories/
│       └── scan_repository.dart
└── presentation/
    ├── providers.dart
    └── screens/
        ├── home_screen.dart
        └── details_screen.dart
```

### Layer Responsibilities

#### **Domain**
- Contains only pure business logic  
- Defines:  
  - `ScanEntity`  
  - `ScanRepository` (abstract)

#### **Data**
- Implements repository logic  
- Handles:  
  - Clarifai API calls  
  - Wikipedia API calls  
  - Hive database CRUD  
  - Mapping between Models and Entities  

#### **Presentation**
- UI screens  
- Riverpod providers & notifiers  
- No business logic inside widgets  

---

## 🔑 Setup & Installation

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/mohamedchouat/objAi.git
cd objAi
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Configure Clarifai API Key

Open:

```
lib/presentation/providers.dart
```

Replace:

```dart
final clarifaiApiKeyProvider =
    Provider<String>((ref) => 'YOUR_CLARIFAI_API_KEY_HERE');
```

with your real key.

### 4️⃣ Generate Hive Adapters (if models changed)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5️⃣ Run the App

```bash
flutter run
```

---

## 📝 Usage

1. Open the app  
2. Tap **Camera** or **Gallery**  
3. Select an object (example: *Cat*, *Eiffel Tower*, *Car*, *Motorcycle*)  
4. ObjAI will:  
   - Identify object via Clarifai  
   - Fetch summary and image via Wikipedia  
   - Save scan result locally  
5. View rich details in the Details Screen  
6. History persists automatically  

---

## 🗂️ Example Stored Entry (JSON)

```json
{
  "id": "c3f1a820-1a2b-4f0a-bf01-442d88fc983e",
  "label": "Eiffel Tower",
  "summary": "The Eiffel Tower is a wrought-iron lattice tower in Paris...",
  "wikiImage": "https://upload.wikimedia.org/.../Eiffel_Tower.jpg",
  "localImagePath": "/data/user/0/com.objai/files/scan_12345.jpg",
  "date": "2025-01-04 18:22"
}
```

---

## 📦 Dependencies (pubspec excerpt)

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.0.0
  riverpod: ^2.0.0
  flutter_riverpod: ^2.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.0.0
  image_picker: ^1.0.0
  uuid: ^4.0.0

dev_dependencies:
  build_runner: ^2.4.0
  hive_generator: ^2.0.0
```

---

## 🤝 Contributing

Pull requests are welcome!

Before submitting, please run:

```bash
dart format .
```

---

## 🛡️ License

This project is licensed under the **MIT License**.
