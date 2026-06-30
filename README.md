
# 🧰 ToolBox

> A sleek collection of everyday utility mini-apps (**Counter • Calculator • BMI • Todo • Length Converter**) built with Flutter, GetX, and scalable architecture.

**Clean Code • Modular • Responsive • Extensible**

---

# ✨ Overview

ToolBox is a consolidated Flutter application showcasing multiple self-contained utility modules under a unified design system. It demonstrates:

- Separation of concerns using an MVC-inspired architecture (`model`, `views`, `controllers`, `widget`).
- GetX for lightweight, reactive state management and navigation.
- Reusable UI components for a consistent user experience.
- Clean code practices focused on scalability, readability, and feature isolation.

> 🔍 **Developer Note:** This project is intentionally structured for scalability. New utility modules can be added by creating their respective screens inside `views` and business logic inside `controllers` with minimal refactoring.

---

# 🧩 Current Mini Apps

| Tool | Purpose | Highlights |
|------|---------|------------|
| 🔢 **Counter** | Increment & decrement counter | Demonstrates reactive state management using GetX (`count_controller.dart`). |
| 🧮 **Calculator** | Basic arithmetic operations | Handles chained calculations, operators, and decimal values. |
| ⚖️ **BMI Calculator** | Body Mass Index calculation | Includes input validation and dynamically styled BMI results. |
| ✅ **Todo List** | Personal task management | Full CRUD operations with model mapping and local persistence-ready architecture. |
| 📏 **Length Converter** | Unit conversion | Performs dynamic mathematical conversions with real-time updates. |

---

# 📱 Screenshots

> Save your screenshots inside **`assets/screenshots/`** using the filenames below.

<table>
<tr>
<td align="center"><b>🏠 Home Dashboard</b></td>
<td align="center"><b>✅ Todo Manager</b></td>
</tr>

<tr>
<td>
<img src="https://placehold.co/300x650?text=Home+Dashboard" width="250">

<!-- Replace with:
<img src="assets/screenshots/home.png" width="250">
-->
</td>

<td>
<img src="https://placehold.co/300x650?text=Todo+Manager" width="250">

<!-- Replace with:
<img src="assets/screenshots/todo.png" width="250">
-->
</td>
</tr>

<tr>
<td align="center"><b>⚖️ BMI Calculator</b></td>
<td align="center"><b>🧮 Calculator</b></td>
</tr>

<tr>
<td>
<img src="https://placehold.co/300x650?text=BMI+Calculator" width="250">

<!-- Replace with:
<img src="assets/screenshots/bmi.png" width="250">
-->
</td>

<td>
<img src="https://placehold.co/300x650?text=Calculator" width="250">

<!-- Replace with:
<img src="assets/screenshots/calculator.png" width="250">
-->
</td>
</tr>

</table>

### Expected Folder Structure

```text
assets/
└── screenshots/
    ├── home.png
    ├── todo.png
    ├── bmi.png
    └── calculator.png
```

---

# 🏗 Architecture & State Management

The application follows a strict separation of concerns while leveraging GetX for reactive state management and dependency injection.

| Layer | Responsibility | Project Files |
|--------|----------------|---------------|
| `views/` | Screens and navigation | `my_home_page.dart`, `todo_page.dart`, `bmi_calculator.dart` |
| `widget/` | Reusable UI components | `core_input_field_widget.dart`, `task_card_widget.dart` |
| `controllers/` | Business logic and state management | `todo_controller.dart`, `count_controller.dart` |
| `model/` | Data models and object mapping | `todo.dart` (`toMap()` / `fromMap()`) |

---

# 🧠 State Management (GetX)

The project uses **GetX** for reactive UI updates.

Example:

```dart
class TodoController extends GetxController {
  var tasks = <Todo>[].obs;

  // Reactive updates handled effortlessly
}
```

---

# 📁 Project Structure

```text
lib/
├── controllers/
│   ├── count_controller.dart          # Counter state management
│   └── todo_controller.dart           # Todo business logic & CRUD
│
├── model/
│   └── todo.dart                      # Todo model with serialization
│
├── views/
│   ├── add_new_task_screen.dart       # Add new task screen
│   ├── bmi_calculator.dart            # BMI calculator UI
│   ├── calculator_screen.dart         # Calculator UI
│   ├── counter_screen.dart            # Counter UI
│   ├── length_calculator.dart         # Length converter UI
│   ├── my_home_page.dart              # Home dashboard
│   ├── screen_import.dart             # Centralized screen exports
│   └── todo_page.dart                 # Todo list screen
│
├── widget/
│   ├── core_input_field_widget.dart   # Shared input field widget
│   └── task_card_widget.dart          # Reusable todo task card
│
└── main.dart                          # Application entry point
```

---

# 🚀 Getting Started

## Prerequisites

- Flutter SDK (3.x recommended)
- Dart 3.x
- Android Studio / VS Code
- Physical device or emulator

---

## Clone & Run

```bash
git clone https://github.com/your-username/ToolBox.git
cd ToolBox

flutter pub get

flutter run
```

---

# 🧪 Quality & Extensibility

| Area | Demonstration |
|------|---------------|
| **State Management** | Lightweight reactive architecture using GetX. |
| **Clean Architecture** | Clear separation between UI, controllers, widgets, and models. |
| **Reusable Components** | Shared widgets reduce duplication and maintain design consistency. |
| **Modular Design** | Each mini-app is isolated, making future expansion simple. |
| **Data Modeling** | `Todo` model supports serialization (`toMap` / `fromMap`) and is ready for local or cloud persistence. |
| **Scalability** | New tools can be integrated without affecting existing modules. |
| **Maintainability** | Centralized imports through `screen_import.dart` keep the project organized and readable. |

---

# 🤝 Contributing

Pull Requests and Issues are welcome.

Please:

1. Fork the repository.
2. Create a feature branch (`feat/your-feature-name`).
3. Follow the existing folder structure (`views`, `controllers`, `widget`, `model`).
4. Keep widgets small, reusable, and composable.
5. Submit a Pull Request.

---

# 📄 License

This project is licensed under the **MIT License**.

Feel free to use, study, modify, and extend it.

---

# 📬 Contact & Author

**Turjjo Halder**

Feel free to reach out through GitHub Issues for suggestions, discussions, or collaboration ideas.

---

