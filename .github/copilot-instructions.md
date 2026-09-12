# AI Coding Agent Instructions & Architecture Guide

This document provides guidelines, architecture patterns, and conventions for AI coding agents working on this Flutter project (`lithia_flutter`).

---

## 🏗 Project Architecture Overview

This project follows **Clean Architecture** combined with a **Feature-First Presentation Structure**.

```
lib/
├── main.dart                       # App entry point
├── core/                           # Core utilities, data sources, & repository implementations
│   ├── datasources/                # Remote API clients and data sources
│   ├── mappers/                    # Mappers converting Models -> Entities and Enums -> API values
│   ├── models/                     # Data models for API serialization
│   ├── repositories/               # Repository interfaces and implementations
│   ├── service_locator.dart        # Dependency injection setup using GetIt
│   └── utils/                      # Constants, enums (VehicleCondition, VehicleSort), and JSON helpers
├── domain/                         # Pure business logic and domain layer (no UI or Flutter dependencies)
│   ├── entities/                   # Domain entities (Freezed classes)
│   └── usecases/                   # Use case contracts (abstract classes) and implementations
└── presentation/                   # Presentation layer (UI & State Management)
    └── inventory/                  # Inventory feature
        ├── cubit/                  # BLoC/Cubit state management and Freezed sealed state
        ├── widgets/                # Modular UI widgets for the inventory feature
        └── inventory_page.dart     # Main Inventory screen entry
```

---

## 📐 Layer Guidelines & Rules

### 1. Domain Layer (`lib/domain/`)

- **Entities (`lib/domain/entities/`)**:
  - Must be pure domain representations built using `@freezed`.
  - Must not depend on Flutter UI, HTTP libraries, or data models.
- **Use Cases (`lib/domain/usecases/`)**:
  - Every use case must define an `abstract class` interface and a `*Impl` class (e.g. `FetchMakesUseCase` / `FetchMakesUseCaseImpl`).
  - Use cases call `DrivewayRepository` methods.
  - Implementations should be registered in `service_locator.dart`.

### 2. Core & Data Layer (`lib/core/`)

- **Data Sources (`lib/core/datasources/`)**:
  - Responsible for raw API queries (GraphQL via `http.Client`).
- **Models (`lib/core/models/`)**:
  - Data transfer objects representing raw GraphQL API responses.
  - Include `fromJson` constructors.
- **Mappers (`lib/core/mappers/`)**:
  - Model-to-Entity extensions (e.g., `VehicleModelMapper`).
  - Enum-to-API extensions (e.g., `VehicleSortMapper`, `VehicleConditionMapper`).
  - **Rule**: Keep API-specific strings and payloads in `core/mappers/`, keeping domain/UI enums decoupled from raw API strings.
- **Repositories (`lib/core/repositories/`)**:
  - Interface defined in `lib/core/repositories/` and implemented in `DrivewayRepositoryImpl`.
  - Converts network exceptions and maps models to domain entities before returning results to use cases.

### 3. Presentation Layer (`lib/presentation/`)

- **State Management (`flutter_bloc` / Cubit)**:
  - Each feature has its own Cubit and `@freezed` sealed state class (`InventoryState`).
  - State classes use sealed union cases: `Initial`, `Loading`, `Success`, and `Failure`.
  - Use Dart 3 exhaustive pattern matching in `BlocBuilder` widgets:
    ```dart
    return switch (state) {
      InventoryInitial() || InventoryLoading(vehicles: []) => const Center(...),
      InventoryFailure(:final errorMessage, vehicles: []) => ErrorView(...),
      _ => ListView(...),
    };
    ```
- **Widgets (`lib/presentation/<feature>/widgets/`)**:
  - Keep screens (`*_page.dart`) lean by extracting components into reusable widgets.
  - Widgets should receive required callbacks or read Cubits via `context.read<T>()`.

---

## 🛠 Code Style & Conventions

1. **Immutability & Freezed**:
   - Use `@freezed` for domain entities, state classes, and request/response models.
   - Run `dart run build_runner build --delete-conflicting-outputs` whenever Freezed classes change.
2. **Type Safety & Enums**:
   - Use strongly-typed Dart `enum`s for domain concepts (e.g. `VehicleCondition`, `VehicleSort`) rather than raw string values.
3. **Dependency Injection**:
   - All repositories, data sources, use cases, and Cubits are registered in `lib/core/service_locator.dart` via `GetIt`.
   - Register singletons with `registerLazySingleton` and Cubits with `registerFactory`.
4. **Formatting & Diagnostics**:
   - Format Dart files using `dart format`.
   - Ensure zero compile errors or linter warnings via `get_errors`.
