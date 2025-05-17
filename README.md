# weather_app

## Getting Started

# 🌦️ Weather Test App – Flutter Architecture Patterns

A lightweight Flutter application that demonstrates and compares multiple **presentation-layer architectural patterns** using a simple weather forecast use case.

This project is designed to help developers understand how different UI architectures can be implemented and maintained in Flutter.

---

## 📐 Implemented Patterns

This app showcases the following presentation patterns, each implemented in its own module or folder:

| Pattern | Description |
|--------|-------------|
| **MVP** (Model-View-Presenter) | Separates view logic from business logic via a Presenter |
| **VIPER** | A strict separation into View, Interactor, Presenter, Entity, and Router |
| **MVVM** (Model-View-ViewModel) | Uses a ViewModel to manage state and expose data/reactive streams |
| **MVI** (Model-View-Intent) | Unidirectional data flow pattern focused on intents and state reducers |
| **Redux** | Inspired by Redux architecture with a global store and reducers |
| **MVU** (Model-View-Update) | Based on Elm architecture, emphasizes simplicity and immutability |
| **BLoC** (Business Logic Component) | Manages streams of input and output events to decouple logic from UI |

Each pattern is implemented with the same base use case: **fetching and displaying weather data**.

---

## 🚀 Getting Started

```bash
git clone https://github.com/your-username/flutter-weather-patterns.git
cd flutter-weather-patterns
flutter pub get
flutter run

