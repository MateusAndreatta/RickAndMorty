# Rick and Morty Characters 

A small iOS app demonstrating how to fetch Rick & Morty characters using a testable service layer and MVVM architecture, built with modern Swift practices.

Data source:  
https://rickandmortyapi.com/

---

## 📱 Demo

![Demo](https://github.com/MateusAndreatta/RickAndMorty/blob/main/demo.gif)

---

## 🧱 Architecture

The app uses **MVVM (Model–View–ViewModel)**.

Key layers:
- **View**: SwiftUI views
- **ViewModel**: Handles state and business logic
- **Service**: Responsible for networking and API communication

---

## 🔌 Dependency Injection

Since the app is small, a simple `DependencyContainer` was created to centralize and manage app dependencies.

This approach:
- Keeps dependencies explicit
- Makes ViewModels easy to test
- Avoids unnecessary complexity or external libraries

---

## 🧪 Tests

The project includes unit tests for:

- **Service layer** (API calls and error handling)
- **ViewModels** (state changes and business logic)

The goal is to ensure:
- Predictable behavior
- Confidence when refactoring
- Clean separation between networking and UI logic

---

## ▶️ How to Run

This is a standard Xcode project.

### Requirements
- macOS with Xcode 15+
- iOS 17+ Simulator (or a real device)

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/MateusAndreatta/RickAndMorty.git
   ```

2. Open the project:
   ```bash
   cd RickAndMorty
   open RickAndMorty.xcodeproj
   ```

3. Select an iOS Simulator (e.g. iPhone 15)

4. Press Run (⌘R)

No external dependencies or package managers are required.

---

## 🚀 Next Steps

Possible improvements and evolutions for this app:

- **Improve API error handling**  
  Currently, `ApiError` has only two cases, since the app displays a generic error screen.  
  For better observability, it would be useful to differentiate:
  - Networking errors
  - Parsing/decoding errors
  - Invalid responses

- **Add observability**
  - Logging
  - Basic analytics
  - Error tracking hooks

- **Localization**
  - Add `Localizable.strings`
  - Support multiple languages

- **Caching**
  - Network response caching
  - Image caching to reduce data usage  
  - Could be done manually with NSCache or via third-party libraries (e.g. Kingfisher)

- **Navigation / Router**
  - Currently omitted due to having only two screens
  - For a larger app, centralizing navigation would improve maintainability

---

## 🛠 Tech Stack

- Swift
- SwiftUI
- Async/Await
- MVVM
- Unit Tests (XCTest)
- Rick & Morty Public API
