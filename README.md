# IoT App - ThingsBoard Flutter Mobile Application

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-v2.12+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D2.12.0-blue.svg)](https://dart.dev/)
[![ThingsBoard](https://img.shields.io/badge/ThingsBoard-v1.0.6-orange.svg)](https://thingsboard.io/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive Flutter-based mobile application for IoT device management and monitoring, built on the ThingsBoard platform. This application enables real-time monitoring of water parameters (volume, turbidity, temperature) and provides robust IoT device management capabilities.

[Features](#features) • [Architecture](#architecture) • [Installation](#installation) • [Configuration](#configuration) • [Usage](#usage) • [Contributing](#contributing)

</div>

---

## 📑 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Modules](#modules)
- [Authentication](#authentication)
- [Theming](#theming)
- [Internationalization](#internationalization)
- [Platform Support](#platform-support)
- [Dependencies](#dependencies)
- [Development](#development)
- [API Documentation](#api-documentation)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

---

## 🌟 Overview

**IoT App** is a production-ready Flutter mobile application designed for comprehensive IoT device management and real-time monitoring. Built on top of the ThingsBoard IoT platform, this application provides seamless integration with IoT sensors and devices, enabling users to monitor water parameters, manage devices, track alarms, and visualize data through interactive dashboards.

The application was originally developed for water management (AquaCare project), tracking critical parameters like water volume, turbidity, and temperature, with intelligent alarm systems for parameter threshold breaches. However, its modular architecture makes it adaptable for various IoT monitoring scenarios.

### Key Highlights

- 🔄 **Real-time Data Synchronization**: Live updates from IoT devices
- 🎨 **Modern Material Design 3**: Beautiful UI with light/dark theme support
- 🔐 **Secure Authentication**: OAuth2, email/password, and two-factor authentication
- 📊 **Interactive Dashboards**: Visualize IoT data with customizable dashboards
- ⚠️ **Smart Alarm System**: Real-time notifications for threshold breaches
- 🌐 **Multi-tenant Support**: Supports system admin, tenant admin, and customer user roles
- 📱 **Cross-platform**: Runs on Android, iOS, Web, Linux, macOS, and Windows
- 🌍 **Internationalization**: Multi-language support (English, Chinese)

---

## ✨ Features

### Core Functionality

#### 🏠 **Home Dashboard**
- Personalized greeting with user information
- Quick access to home dashboard widgets
- Tenant management for system administrators
- Profile management with avatar display
- Real-time loading indicators

#### 📟 **Device Management**
- View and manage IoT devices
- Device profiles and configurations
- Device details with attributes and telemetry
- Device grouping and filtering
- QR code scanning for quick device addition
- Device status monitoring

#### ⚠️ **Alarm Management**
- Real-time alarm monitoring
- Alarm acknowledgment and clearing
- Alarm filtering by status, severity, and type
- Detailed alarm information
- Alarm history tracking
- Push notifications for critical alarms

#### 📊 **Dashboard Visualization**
- Interactive ThingsBoard dashboards
- Fullscreen dashboard mode
- Dashboard navigation and state management
- Custom widget interactions
- Responsive dashboard layout

#### 🏢 **Asset Management**
- Asset hierarchy visualization
- Asset details and attributes
- Asset-device relationships
- Asset filtering and search

#### 👥 **Customer Management**
- Customer creation and editing
- Customer device assignments
- Customer user management
- Contact information management

#### 👤 **User Profile**
- Profile information viewing and editing
- Password change functionality
- User preferences and settings
- Avatar display

#### 📝 **Audit Logs**
- System activity tracking
- User action history
- Detailed audit log viewer
- Filtering and search capabilities

#### 🎯 **Additional Features**
- Offline support with secure local storage
- Geolocation services for device tracking
- Image picker for profile and device photos
- URL launcher for external links
- Material Design Icons integration
- Responsive UI for various screen sizes

---

## 🏗 Architecture

The application follows a clean, modular architecture pattern with clear separation of concerns:

### Architecture Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                        Presentation Layer                    │
│  (Pages, Widgets, UI Components, Theme Management)          │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│                      Business Logic Layer                    │
│    (TbContext, Navigation, State Management, Routes)        │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│                       Data Layer                             │
│  (ThingsBoard Client, Services, Storage, API Calls)         │
└─────────────────────────────────────────────────────────────┘
```

### Key Architectural Components

#### **1. TbContext (Core Context)**
The central context manager that handles:
- ThingsBoard client initialization
- Authentication state management
- Navigation and routing
- Error handling and notifications
- User session management
- OAuth2 integration
- Two-factor authentication flow

#### **2. Modular Structure**
Each feature is organized as a self-contained module:
```
modules/
├── alarm/          # Alarm management
├── asset/          # Asset management
├── audit_log/      # Audit logging
├── customer/       # Customer management
├── dashboard/      # Dashboard visualization
├── device/         # Device management
├── home/           # Home screen
├── main/           # Main navigation
├── more/           # Settings and more options
├── profile/        # User profile
└── tenant/         # Tenant management
```

#### **3. Context-Widget Pattern**
- `TbContextWidget`: Base widget with context access
- `TbContextState`: State management with lifecycle hooks
- `TbPageWidget`: Page-specific implementation
- `TbPageState`: Page state with route awareness

#### **4. Two-Page Navigation System**
Innovative dual MaterialApp architecture:
- **First App**: Main navigation (Home, Devices, Alarms, More)
- **Second App**: Dashboard viewer with fullscreen support
- Seamless transitions between apps using `TwoPageView`

#### **5. Service Layer**
- `WidgetActionHandler`: Handles dashboard widget interactions
- `TbAppStorage`: Secure local storage abstraction
- `EntityQueryApi`: Efficient entity data fetching
- `DeviceProfileCache`: Performance optimization

---

## 🛠 Tech Stack

### Frontend Framework
- **Flutter**: v2.12+ (Cross-platform UI framework)
- **Dart**: >=2.12.0 <3.0.0 (Programming language with null safety)

### Backend & IoT Platform
- **ThingsBoard**: Open-source IoT platform
- **ThingsBoard Client SDK**: v1.0.6 (Dart client library)

### State Management & Navigation
- **Fluro**: v2.0.3 (Advanced routing library)
- **ValueNotifier**: Built-in Flutter state management

### UI Components & Styling
- **Material Design 3**: Latest Material Design guidelines
- **Google Fonts**: v4.0.4 (Lato font family)
- **Flutter SVG**: v1.1.3 (SVG rendering)
- **Auto Size Text**: v3.0.0 (Responsive text)
- **Material Design Icons Flutter**: v5.0.5955 (Extended icon set)

### Storage & Security
- **Flutter Secure Storage**: v6.0.0 (Encrypted storage)
- **Dart JWT**: v2.2.0 (Token handling)
- **Crypto**: v3.0.1 (Encryption utilities)

### Device & Platform Integration
- **Device Info Plus**: v4.1.2 (Device information)
- **Geolocator**: v9.0.1 (Location services)
- **Package Info**: v2.0.2 (App information)
- **Universal Platform**: v1.0.0 (Platform detection)
- **Universal HTML**: v2.0.8 (Web compatibility)

### Media & Utilities
- **Image Picker**: v0.8.0 (Camera and gallery access)
- **QR Code Scanner**: v1.0.0 (QR code reading)
- **URL Launcher**: v6.0.3 (External URL handling)
- **MIME**: v1.0.0 (MIME type detection)

### UI Enhancements
- **Flutter Speed Dial**: v6.0.0 (Floating action button menu)
- **Infinite Scroll Pagination**: v3.0.1 (Efficient list pagination)
- **Fading Edge ScrollView**: v3.0.0 (Scrolling effects)
- **Preload Page View**: v0.1.6 (Page preloading)

### WebView
- **Flutter InAppWebView**: Custom fork (Dashboard rendering)

### Development Tools
- **Logger**: v1.0.0 (Advanced logging)
- **Stream Transform**: v2.0.0 (Stream utilities)

### Forms & Validation
- **Flutter Form Builder**: v7.0.0 (Dynamic forms)
- **Form Builder Validators**: v8.3.0 (Input validation)

### Theming
- **Adaptive Theme**: v3.2.1 (Dynamic theme switching)

### Internationalization
- **Flutter Localizations**: Built-in (Localization support)
- **Intl**: v0.17.0 (Internationalization utilities)

---

## 📁 Project Structure

```
iot_app/
├── android/                    # Android platform configuration
├── ios/                        # iOS platform configuration
├── linux/                      # Linux platform configuration
├── macos/                      # macOS platform configuration
├── windows/                    # Windows platform configuration
├── web/                        # Web platform configuration
├── assets/
│   └── images/                 # Image assets
├── lib/
│   ├── main.dart               # Application entry point
│   ├── config/
│   │   ├── routes/             # Route configuration
│   │   │   └── router.dart     # Main router setup
│   │   └── themes/             # Theme configuration
│   │       └── tb_theme.dart   # Light and dark themes
│   ├── constants/
│   │   ├── app_colors.dart     # Color definitions
│   │   ├── app_constants.dart  # API endpoints and constants
│   │   └── assets_path.dart    # Asset path constants
│   ├── core/
│   │   ├── auth/               # Authentication logic
│   │   │   ├── login/          # Login screens
│   │   │   ├── oauth2/         # OAuth2 implementation
│   │   │   └── web/            # Web-specific auth
│   │   ├── context/            # Application context
│   │   │   ├── tb_context.dart # Core context manager
│   │   │   └── tb_context_widget.dart
│   │   ├── entity/             # Base entity classes
│   │   └── init/               # Initialization logic
│   ├── generated/              # Generated files
│   │   ├── l10n.dart           # Localization
│   │   └── intl/               # Internationalization
│   ├── l10n/                   # Localization resources
│   │   ├── intl_en.arb         # English translations
│   │   └── intl_zh.arb         # Chinese translations
│   ├── modules/
│   │   ├── alarm/              # Alarm management module
│   │   │   ├── alarms_page.dart
│   │   │   ├── alarms_list.dart
│   │   │   ├── alarms_base.dart
│   │   │   └── alarm_routes.dart
│   │   ├── asset/              # Asset management module
│   │   │   ├── assets_page.dart
│   │   │   ├── assets_list.dart
│   │   │   ├── asset_details_page.dart
│   │   │   └── asset_routes.dart
│   │   ├── audit_log/          # Audit log module
│   │   ├── customer/           # Customer management module
│   │   ├── dashboard/          # Dashboard module
│   │   │   ├── main_dashboard_page.dart
│   │   │   ├── dashboards_page.dart
│   │   │   ├── fullscreen_dashboard_page.dart
│   │   │   └── dashboard_routes.dart
│   │   ├── device/             # Device management module
│   │   │   ├── devices_page.dart
│   │   │   ├── devices_list.dart
│   │   │   ├── device_details_page.dart
│   │   │   └── device_routes.dart
│   │   ├── home/               # Home screen module
│   │   │   ├── home_page.dart
│   │   │   └── home_routes.dart
│   │   ├── main/               # Main navigation module
│   │   │   └── main_page.dart
│   │   ├── more/               # More options module
│   │   │   └── more_page.dart
│   │   ├── profile/            # User profile module
│   │   │   ├── profile_page.dart
│   │   │   ├── change_password_page.dart
│   │   │   └── profile_routes.dart
│   │   └── tenant/             # Tenant management module
│   ├── utils/
│   │   ├── services/           # Utility services
│   │   │   ├── widget_action_handler.dart
│   │   │   ├── tb_app_storage.dart
│   │   │   └── entity_query_api.dart
│   │   ├── transition/         # Page transitions
│   │   ├── ui/                 # UI utilities
│   │   └── utils.dart
│   └── widgets/                # Reusable widgets
│       ├── tb_app_bar.dart
│       ├── tb_progress_indicator.dart
│       ├── two_page_view.dart
│       └── two_value_listenable_builder.dart
├── test/                       # Test files
├── analysis_options.yaml       # Dart analyzer configuration
├── pubspec.yaml               # Project dependencies
├── LICENSE                    # MIT License
└── README.md                  # This file
```

---

## 📦 Installation

### Prerequisites

- **Flutter SDK**: Version 2.12 or higher
- **Dart SDK**: Version 2.12.0 or higher
- **Android Studio** / **Xcode** (for mobile development)
- **ThingsBoard Server**: Running instance (cloud or local)
- **Git**: Version control

### Step 1: Clone the Repository

```bash
git clone https://github.com/amanat-2003/thingsboard_iot_app.git
cd thingsboard_iot_app
```

### Step 2: Install Flutter Dependencies

```bash
flutter pub get
```

### Step 3: Generate Localization Files

```bash
flutter pub run intl_utils:generate
```

### Step 4: Platform-Specific Setup

#### Android
```bash
cd android
./gradlew clean
cd ..
```

#### iOS
```bash
cd ios
pod install
cd ..
```

#### Web
No additional setup required.

### Step 5: Run the Application

```bash
# Run on connected device
flutter run

# Run on specific platform
flutter run -d android
flutter run -d ios
flutter run -d chrome
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

### Step 6: Build Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Desktop
flutter build macos --release
flutter build windows --release
flutter build linux --release
```

---

## ⚙️ Configuration

### ThingsBoard Server Configuration

Edit `lib/constants/app_constants.dart`:

```dart
abstract class ThingsboardAppConstants {
  // Set your ThingsBoard server endpoint
  static final thingsBoardApiEndpoint = 'https://your-server.com/';
  
  // OAuth2 configuration
  static final thingsboardOAuth2CallbackUrlScheme = 'org.thingsboard.app.auth';
  
  // App secret (for development only)
  static final thingsboardOAuth2AppSecret = 'your-secret-key';
}
```

### Environment Variables

For production, use environment variables:

```bash
export TB_API_ENDPOINT='https://your-server.com/'
export TB_OAUTH2_SECRET='your-secret-key'
```

### App Icons

Configure app icons in `pubspec.yaml`:

```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  remove_alpha_ios: true
  image_path: "assets/images/OnlyLogo.png"
```

Generate icons:
```bash
flutter pub run flutter_launcher_icons:main
```

### Localization

Add or modify translations in:
- `lib/l10n/intl_en.arb` (English)
- `lib/l10n/intl_zh.arb` (Chinese)

Regenerate localization:
```bash
flutter pub run intl_utils:generate
```

---

## 🚀 Usage

### First Launch

1. **Launch Application**: Open the app on your device
2. **Login Screen**: Enter your ThingsBoard credentials
3. **Authentication**: Support for email/password, OAuth2, or 2FA
4. **Home Dashboard**: View your personalized dashboard

### Main Navigation

The app features bottom navigation with role-based access:

#### **System Administrator**
- Home
- More (Settings & Administration)

#### **Tenant Administrator**
- Home
- Alarms
- Devices
- More

#### **Customer User**
- Home
- Alarms
- Devices
- More

### Common Workflows

#### **Monitoring Devices**
1. Navigate to **Devices** tab
2. View list of all devices
3. Tap on device for details
4. View real-time telemetry data

#### **Managing Alarms**
1. Navigate to **Alarms** tab
2. View active alarms sorted by severity
3. Tap alarm to view details
4. Acknowledge or clear alarms

#### **Viewing Dashboards**
1. From **Home**, tap on a dashboard
2. Interact with dashboard widgets
3. View in fullscreen mode
4. Navigate back to main app

#### **Profile Management**
1. Tap profile avatar on home screen
2. View/edit profile information
3. Change password
4. Update preferences

---

## 📚 Modules

### Alarm Module
**Location**: `lib/modules/alarm/`

**Features**:
- Real-time alarm monitoring
- Alarm list with filtering
- Alarm acknowledgment and clearing
- Severity-based color coding
- Alarm details view

**Key Files**:
- `alarms_page.dart`: Main alarm screen
- `alarms_list.dart`: Alarm list widget
- `alarms_base.dart`: Base alarm logic
- `alarm_routes.dart`: Routing configuration

### Device Module
**Location**: `lib/modules/device/`

**Features**:
- Device list with pagination
- Device details and attributes
- Device telemetry viewing
- Device profiles
- QR code scanning

**Key Files**:
- `devices_main_page.dart`: Main device screen
- `devices_list.dart`: Device list widget
- `device_details_page.dart`: Device details
- `device_routes.dart`: Routing configuration

### Dashboard Module
**Location**: `lib/modules/dashboard/`

**Features**:
- Dashboard viewing
- Widget interactions
- Fullscreen mode
- Dashboard state management
- Dynamic dashboard loading

**Key Files**:
- `main_dashboard_page.dart`: Dashboard viewer
- `dashboards_page.dart`: Dashboard selection
- `fullscreen_dashboard_page.dart`: Fullscreen view
- `dashboard.dart`: Dashboard integration

### Asset Module
**Location**: `lib/modules/asset/`

**Features**:
- Asset management
- Asset hierarchy
- Asset details
- Asset-device relationships

### Customer Module
**Location**: `lib/modules/customer/`

**Features**:
- Customer management
- Customer details
- Contact information
- User assignments

### Profile Module
**Location**: `lib/modules/profile/`

**Features**:
- User profile viewing
- Profile editing
- Password change
- Avatar management

### Audit Log Module
**Location**: `lib/modules/audit_log/`

**Features**:
- Activity tracking
- Audit log viewing
- Log filtering
- Detailed log information

---

## 🔐 Authentication

### Supported Authentication Methods

#### 1. **Email/Password Authentication**
- Standard login with credentials
- Secure password storage
- Remember me functionality

#### 2. **OAuth2 Authentication**
- Google Sign-In
- GitHub Sign-In
- Custom OAuth2 providers
- PKCE flow support

#### 3. **Two-Factor Authentication (2FA)**
- TOTP-based authentication
- SMS verification
- Email verification
- Backup codes

### Authentication Flow

```
┌─────────────┐
│Login Screen │
└──────┬──────┘
       │
       ├──────────────────────┬──────────────────────┬──────────────────┐
       │                      │                      │                  │
       ▼                      ▼                      ▼                  ▼
┌──────────┐          ┌──────────┐         ┌──────────┐       ┌──────────┐
│Email/Pass│          │  OAuth2  │         │   2FA    │       │   Web    │
└────┬─────┘          └────┬─────┘         └────┬─────┘       └────┬─────┘
     │                     │                     │                  │
     └─────────────────────┴─────────────────────┴──────────────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │  Authenticated  │
                            │   TbContext     │
                            └────────┬────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │   Home Screen   │
                            └─────────────────┘
```

### Token Management

- **Access Token**: Stored securely
- **Refresh Token**: Auto-renewal
- **Token Expiration**: Automatic handling
- **Secure Storage**: Flutter Secure Storage

---

## 🎨 Theming

### Material Design 3

The app implements Material Design 3 with dynamic color schemes:

#### **Light Theme**
- Background: `#F5F5F5`
- Primary: `#11C3A9` (Teal/Turquoise)
- Surface: White with elevation
- On-Surface: Dark text

#### **Dark Theme**
- Background: `#121212`
- Primary: `#11C3A9` (Teal/Turquoise)
- Surface: Dark elevated surfaces
- On-Surface: Light text

### Typography

- **Font Family**: Lato (via Google Fonts)
- **Text Styles**: Material Design 3 scale
- **Responsive Text**: Auto-size text for various screens

### Color Customization

Edit `lib/constants/app_colors.dart`:

```dart
class AppColors {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: lightSeedColor,
    brightness: Brightness.light,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: darkSeedColor,
    brightness: Brightness.dark,
  );
  
  static final lightSeedColor = Color(0xFF11C3A9);
  static final darkSeedColor = Color(0xFF11C3A9);
}
```

### Theme Configuration

Edit `lib/config/themes/tb_theme.dart` for advanced customization.

---

## 🌍 Internationalization

### Supported Languages

- **English** (en)
- **Chinese** (zh)

### Adding New Languages

1. Create `intl_<locale>.arb` in `lib/l10n/`
2. Add translations
3. Run `flutter pub run intl_utils:generate`
4. Add locale to supported locales

### Usage in Code

```dart
import 'package:iot_app/generated/l10n.dart';

// In widgets
Text(S.of(context).home)
Text(S.of(context).devices)
Text(S.of(context).alarms)
```

---

## 📱 Platform Support

### ✅ Fully Supported Platforms

- **Android**: API 21+ (Android 5.0 Lollipop and above)
- **iOS**: iOS 11.0 and above
- **Web**: Modern browsers (Chrome, Firefox, Safari, Edge)

### ⚠️ Experimental Support

- **macOS**: macOS 10.14+
- **Windows**: Windows 10+
- **Linux**: Ubuntu 18.04+

### Platform-Specific Features

#### Android
- Material Design components
- Adaptive icons
- Background services
- Push notifications

#### iOS
- Cupertino widgets where appropriate
- iOS-specific permissions
- Apple Push Notification Service
- Background fetch

#### Web
- Progressive Web App (PWA) capable
- Responsive design
- Web-specific authentication flow

---

## 📚 Dependencies

### Production Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `thingsboard_client` | 1.0.6 | ThingsBoard API client |
| `flutter_secure_storage` | 6.0.0 | Secure local storage |
| `fluro` | 2.0.3 | Advanced routing |
| `google_fonts` | 4.0.4 | Custom fonts |
| `flutter_inappwebview` | Custom | WebView for dashboards |
| `device_info_plus` | 4.1.2 | Device information |
| `geolocator` | 9.0.1 | Location services |
| `image_picker` | 0.8.0 | Camera/gallery access |
| `qr_code_scanner` | 1.0.0 | QR code scanning |
| `url_launcher` | 6.0.3 | External URLs |
| `logger` | 1.0.0 | Logging framework |

For complete list, see [pubspec.yaml](pubspec.yaml).

### Development Dependencies

- `flutter_test`: Testing framework
- `flutter_launcher_icons`: Icon generation

---

## 🔧 Development

### Code Style

The project follows Dart official style guide:

```bash
# Format code
flutter format lib/

# Analyze code
flutter analyze
```

### Linting

Configure in `analysis_options.yaml`.

### Logging

Use built-in logger:

```dart
// In widgets with TbContext
log.debug('Debug message');
log.info('Info message');
log.warn('Warning message');
log.error('Error message', error, stackTrace);
```

### State Management

The app uses a combination of:
- `ValueNotifier` for reactive state
- `TbContext` for global application state
- `TbContextState` for widget-level state

### Adding New Modules

1. Create module directory in `lib/modules/`
2. Create routes file extending `TbRoutes`
3. Register routes in `router.dart`
4. Implement pages extending `TbPageWidget`
5. Implement state extending `TbPageState`

### Testing

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

---

## 📖 API Documentation

### ThingsBoard Client

The app uses `thingsboard_client` package for API communication:

```dart
// Access client
tbClient.getDeviceService()
tbClient.getAlarmService()
tbClient.getDashboardService()
tbClient.getAssetService()
tbClient.getUserService()
```

### Key Services

- **DeviceService**: Device CRUD operations
- **AlarmService**: Alarm management
- **DashboardService**: Dashboard operations
- **AssetService**: Asset management
- **UserService**: User operations
- **TelemetryWebsocketService**: Real-time data

### API Endpoints

Configured in `app_constants.dart`:
- Base URL: Configurable ThingsBoard endpoint
- Default: `https://www.purgyiltechnologies.com/`

---

## 🐛 Troubleshooting

### Common Issues

#### Build Errors

**Issue**: `Gradle build failed`
```bash
# Solution
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

**Issue**: `Pod install failed`
```bash
# Solution
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

#### Runtime Issues

**Issue**: `Unable to connect to ThingsBoard`
- Check `app_constants.dart` endpoint configuration
- Verify network connectivity
- Ensure ThingsBoard server is accessible

**Issue**: `Authentication failed`
- Verify credentials
- Check OAuth2 configuration
- Ensure server accepts login method

#### Platform Issues

**Issue**: Web app not loading
- Clear browser cache
- Check console for errors
- Verify CORS settings on server

**Issue**: iOS build issues
- Update Xcode to latest version
- Run `pod repo update`
- Check code signing

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### Getting Started

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### Contribution Guidelines

- Follow Dart style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation
- Ensure CI/CD passes

### Code Review Process

1. Automated checks must pass
2. Code review by maintainers
3. Address feedback
4. Merge after approval

### Reporting Bugs

Use GitHub Issues with:
- Clear title
- Detailed description
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Environment details

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2024 Amanat Singh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

See [LICENSE](LICENSE) file for details.

---

## 📞 Contact

**Amanat Singh**

- 📧 Email: [amanatsinghnain@gmail.com](mailto:amanatsinghnain@gmail.com)
- 💼 LinkedIn: [linkedin.com/in/amanat-coder](https://www.linkedin.com/in/amanat-coder/)
- 🌐 Website: [amanatsingh.tech](https://amanatsingh.tech)
- 💻 GitHub: [@amanat-2003](https://github.com/amanat-2003)

---

## 🙏 Acknowledgments

### Project Links

- **AquaCare App Demo Video**: 
  
  [![AquaCare App Demo](https://img.youtube.com/vi/v92SRcnVp44/0.jpg)](https://www.youtube.com/watch?v=v92SRcnVp44)

- **Blog Post**: [Read about AquaCare](https://amanatsingh.tech/aquacare)
- **Original Repository**: [AquaCare GitHub](https://github.com/amanat-2003/aquacare)

### Built With

- [Flutter](https://flutter.dev/) - UI Framework
- [ThingsBoard](https://thingsboard.io/) - IoT Platform
- [Material Design 3](https://m3.material.io/) - Design System
- [Google Fonts](https://fonts.google.com/) - Typography

### Special Thanks

- ThingsBoard team for the excellent IoT platform
- Flutter community for amazing packages and support
- All contributors and users of this project

---

## 📊 Project Stats

- **Version**: 1.0.6
- **Flutter SDK**: >=2.12.0 <3.0.0
- **Platforms**: 6 (Android, iOS, Web, macOS, Windows, Linux)
- **Languages**: 2 (English, Chinese)
- **Modules**: 11
- **Dependencies**: 30+

---

## 🗺️ Roadmap

### Upcoming Features

- [ ] Push notifications for alarms
- [ ] Offline data synchronization
- [ ] Advanced analytics and reports
- [ ] Custom dashboard creation
- [ ] Widget library expansion
- [ ] Multi-language support expansion
- [ ] Accessibility improvements
- [ ] Performance optimizations
- [ ] Unit and integration tests
- [ ] CI/CD pipeline

---

## 💡 Use Cases

This application is ideal for:

- **Water Management**: Monitor water quality parameters
- **Smart Buildings**: Track building IoT sensors
- **Industrial IoT**: Monitor equipment and machinery
- **Agriculture**: Track soil moisture, temperature
- **Smart Cities**: Monitor various city sensors
- **Energy Management**: Track energy consumption
- **Environmental Monitoring**: Air quality, weather stations

---

<div align="center">

### ⭐ Star this repository if you find it useful!

**Made with ❤️ by Amanat Singh**

*Promoting sustainability and environmental consciousness through innovative IoT solutions*

[⬆ Back to Top](#iot-app---thingsboard-flutter-mobile-application)

</div>
