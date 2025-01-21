# Task-management-app 

## Description
This is a Flutter project that uses MVVM architecture to structure the app. It includes features like local notifications, data storage, and more, with a clean and maintainable structure.

The app supports theme changes based on the system preferences, allowing users to switch between light and dark modes automatically.

## Installation

To install the app on your Android smartphone:

1. Download the APK file from the "App" folder.
2. Open the downloaded file to install the app on your device.

Ensure you have allowed installation from unknown sources in your device settings if required.

## Screenshots

App screenshots can be found in the "App" folder.

## Packages Used

This project utilizes the following packages:

- `flutter_riverpod`: ^2.6.1
- `sqflite`: ^2.4.1
- `equatable`: ^2.0.7
- `font_awesome_flutter`: ^10.8.0
- `flutter_local_notifications`: ^18.0.1
- `permission_handler`: ^11.3.1
- `cupertino_icons`: ^1.0.8
- `flex_color_scheme`: ^8.1.0
- `gap`: ^3.0.1
- `google_fonts`: ^6.2.1
- `intl`: ^0.20.1
- `path`: ^1.9.0
- `flutter_native_splash`: ^2.4.4
- `timezone`: ^0.10.0
- `animated_splash_screen`: ^1.3.0
- `lottie`: ^3.3.1

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture, separating the logic of the app into different layers for better maintainability, testability, and scalability.

- **Model**: Represents the data layer and handles data fetching, storage, etc.
- **View**: Displays the UI and binds to the ViewModel for data updates.
- **ViewModel**: Handles the business logic and communicates between the View and Model.

## Theme

The app's theme can automatically switch between **light** and **dark** modes based on the system preferences. This allows the user to experience a seamless visual experience that aligns with their device settings.

## Setup

To get started with the development setup on your local machine, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/kartikBainola/Task-management-app.git
