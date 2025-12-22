# 🎮 PixelChat - Real-Time Pixel Art Messaging App

A pixel art style real-time chat app built with Flutter and Firebase. Connect with family and friends in retro 8-bit style!

![PixelChat](https://img.shields.io/badge/Flutter-3.19-blue) ![Firebase](https://img.shields.io/badge/Firebase-Latest-orange) ![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### 🎮 Pixel Art Design
- 8-bit pixelated UI elements and borders
- Retro gaming color scheme
- Pixel-style icons, avatars, and buttons

### 💬 Real-Time Messaging
- Cross-device real-time chat
- Message bubbles with pixel borders
- Typing indicators and online status
- Instant message delivery

### 🔐 User Authentication
- Email/password registration
- Secure user sessions
- Random pixel emoji avatars

### 📸 Status Updates
- 24-hour status updates
- Custom status creation
- Recent updates section

### 📞 Call History
- Voice and video call logs
- Call duration tracking

## 🚀 Quick Start

### 📱 Download APK
1. Go to **[Actions](https://github.com/YOUR_USERNAME/pixelchat/actions)** tab
2. Click on the latest workflow run
3. Download `pixelchat-apk` artifact
4. Extract and install `app-release.apk` on your Android phone

### 🔨 Build from Source

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/pixelchat.git
cd pixelchat

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK
flutter build apk --release
```

## 📸 Screenshots

<!-- Add your app screenshots here -->

## 🔥 Firebase Setup

The app comes pre-configured with Firebase. For your own Firebase project:

1. Create Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android app with package name: `com.example.pixelchat`
3. Enable Email/Password authentication
4. Set up Firestore database
5. Download `google-services.json` and place in `android/app/`

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

## 🏗️ Project Structure

```
pixelchat/
├── lib/
│   ├── models/          # Data models
│   ├── screens/         # App screens
│   ├── services/        # Firebase services
│   ├── themes/          # Pixel art theme
│   └── widgets/         # Custom widgets
├── android/             # Android configuration
└── assets/              # Images and fonts
```

## 🛠️ Tech Stack

- **Flutter** - UI Framework
- **Firebase** - Backend services
- **Firestore** - Real-time database
- **Firebase Auth** - Authentication
- **Provider** - State management

## 🌐 How It Works

- Anyone with the APK can create an account
- Users can discover and chat with each other
- Real-time sync across all devices
- Works globally with internet connection
- Firebase handles all backend services

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Add new pixel art elements
- Improve the retro design
- Add new features
- Fix bugs

## 📧 Support

For issues and questions, please open a GitHub issue.

---

**Made with ❤️ and pixels! 🎮💬**
