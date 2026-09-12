# 🚗 Driveway Mobile — Flutter Clean Architecture Showcase

A production-grade, highly modular Flutter application built to showcase modern mobile engineering practices, reverse-engineered and integrated directly with **Driveway's live GraphQL API** (`api-gateway.driveway.com`).

---

## 🎯 Motivation

I built this project to demonstrate clean architecture patterns, state management rigor, and UI responsiveness using real-world GraphQL APIs. As an admirer of Driveway’s smooth car-buying experience, I wanted to reimagine the vehicle inventory browsing flow in Flutter—focusing on type safety, strict separation of concerns, and maintainable mobile architecture.

---

## 🏗 Architecture & Engineering Highlights

This project adheres strictly to **Clean Architecture** principles combined with a **Feature-First Presentation Structure**:

```
lib/
├── core/                           # Data sources, GraphQL client, models & mappers
│   ├── datasources/                # Raw GraphQL network requests via http
│   ├── mappers/                    # Extensions decoupling API payload strings from UI enums
│   ├── models/                     # API Data Transfer Objects (DTOs)
│   ├── repositories/               # Repository implementations
│   └── utils/                      # Enums (VehicleCondition, VehicleSort) & JSON helpers
├── domain/                         # Pure Business Logic (Zero UI or HTTP dependencies)
│   ├── entities/                   # Immutable Freezed domain models
│   └── usecases/                   # Isolated Use Case contracts & implementations
└── presentation/                   # Feature-First Presentation Layer
    └── inventory/                  # Vehicle Inventory Feature
        ├── cubit/                  # BLoC/Cubit state management & sealed states
        ├── widgets/                # Modular UI widgets (VehicleCard, FilterSheet, etc.)
        └── inventory_page.dart     # Feature entry screen
```

### Key Technical Patterns

- **Pure Domain Layer**: Use Cases (`SearchVehiclesUseCase`, `FetchMakesUseCase`) and Entities (`Vehicle`, `UserLocation`) have zero external framework dependencies.
- **Sealed State Management**: BLoC (`flutter_bloc` / `Cubit`) using **Dart 3 sealed classes** (`InventoryInitial`, `InventoryLoading`, `InventorySuccess`, `InventoryFailure`) with exhaustive pattern matching (`switch (state)`).
- **Type-Safe API Mappers**: GraphQL enum strings (`'PRICE_LOWEST'`, `'YEAR_NEWEST'`, `'USED'`) are completely decoupled from UI enums (`VehicleSort`, `VehicleCondition`) using dedicated mapper extensions in `core/mappers/`.
- **Smart Query Caching**: `InventoryCubit` intelligently caches vehicle makes in state during sorting changes, only re-fetching makes when condition filters or pull-to-refresh actions occur.
- **Dependency Injection**: Loose coupling managed via `GetIt` service locator ([lib/core/service_locator.dart](lib/core/service_locator.dart)).

---

## ✨ Features

- 🚘 **Live Vehicle Search**: Real-time vehicle inventory fetching backed by Driveway GraphQL queries.
- ⚡ **Server-Side Sorting**: Directly queries GraphQL `sortCriteria` (`RELEVANCE`, `PRICE_LOWEST`, `PRICE_HIGHEST`, `MILEAGE_LOWEST`, `YEAR_NEWEST`, etc.).
- 🎛 **Multi-Select Condition Filtering**: Filter simultaneously across `New`, `Used`, and `Certified Pre-Owned` (`CPO`) inventory.
- 📍 **Location-Aware Payload**: Integrates `userLocation` (`postalCode`, `state`) into GraphQL requests.
- 🔄 **Pull-to-Refresh**: Seamless inventory reloading using native `RefreshIndicator`.
- 📱 **Adaptive UI**: Clean, responsive bottom sheets for filtering and sorting with custom design tokens.

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart 3)
- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) / `Cubit`
- **Code Generation & Immutability**: [`freezed`](https://pub.dev/packages/freezed) & [`build_runner`](https://pub.dev/packages/build_runner)
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it)
- **Networking**: `http` (GraphQL over HTTP)

---

## 🚀 Getting Started

### 1. Clone & Install Dependencies

```bash
git clone https://github.com/Adityavns/lithia-flutter.git
cd lithia_flutter
flutter pub get
```

### 2. Generate Freezed Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App

Pass the API subscription key via `--dart-define` at launch time:

```bash
flutter run --dart-define=DRIVEWAY_API_KEY=your_driveway_subscription_key
```

---

## 📬 Contact & Connect

If you're an engineer or recruiter at **Driveway / Lithia & Driveway**, I'd love to connect! I built this project to demonstrate my passion for building clean, scalable mobile apps.

- **GitHub**: [@Adityavns](https://github.com/Adityavns)
- **Project Repository**: [Adityavns/lithia-flutter](https://github.com/Adityavns/lithia-flutter)
