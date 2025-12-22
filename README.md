# PixelChat

A pixel art style real-time chat app built with Flutter and Firebase.

## Features

### 🎮 Pixel Art Design
- 8-bit pixelated UI elements and borders
- Retro gaming color scheme with classic chat green
- Pixel-style icons, avatars, and buttons
- Custom pixel font support

### 💬 Real-Time Messaging
- Cross-device real-time chat functionality
- Message bubbles with pixel borders
- Typing indicators and online status
- Unread message counters
- Instant message delivery

### 🔐 User Authentication
- Email/password registration and login
- Automatic profile creation
- Random pixel emoji avatars
- Secure user sessions

### 📸 Status Updates
- WhatsApp Status clone functionality
- Custom status creation and viewing
- Recent updates section
- 24-hour status expiry

### 📞 Call History
- Voice and video call logs
- Missed/incoming/outgoing call status
- Call duration tracking

### ⚙️ Settings
- Profile management with pixel avatars
- Light/Dark theme switching
- Privacy and security settings

## Installation & Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Android SDK and Studio
- Firebase project

### Firebase Setup
1. Create Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android app with package name: `com.example.pixelchat`
3. Enable Email/Password authentication
4. Set up Firestore database
5. Download `google-services.json` and place in `android/app/`

### Build Instructions

```bash
# Clone and navigate to the project
cd pixelchat

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK for distribution
flutter build apk --release
```

## Project Structure

```
pixelchat/
├── lib/
│   ├── models/          # Data models (Chat, Message, Status, Call)
│   ├── screens/         # Main app screens
│   ├── services/        # Firebase services and business logic
│   ├── themes/          # Pixel art theme and colors
│   ├── widgets/         # Custom pixel-styled widgets
│   └── main.dart        # App entry point
├── android/             # Android configuration
├── ios/                 # iOS configuration
├── assets/              # Images and fonts
└── FIREBASE_SETUP.md    # Detailed Firebase setup guide
```

## Real-Time Features

### Database Architecture
- **Firestore** for real-time data sync
- **Firebase Auth** for user authentication
- **Cloud Storage** for media files
- Cross-device synchronization

### Chat System
- Real-time message delivery
- User discovery and contacts
- Online/offline status tracking
- Message read receipts

## Screens

1. **Auth Screen** - Login and registration
2. **Home Screen** - Main navigation with 4 tabs
3. **Chats Screen** - Chat list with pixel styling
4. **Chat Screen** - Individual real-time chat interface
5. **Status Screen** - Status updates (24-hour expiry)
6. **Calls Screen** - Call history and logs
7. **Settings Screen** - App configuration

## How It Works

### Multi-User Support
- Anyone with the APK can create an account
- Users can discover and chat with each other
- No local pairing or Bluetooth required
- Works globally with internet connection

### Real-Time Sync
- Messages sync instantly across all devices
- Online status updates in real-time
- Push notifications (ready for implementation)
- Offline support with sync when back online

## Technical Details

### Key Dependencies
- `firebase_core` - Firebase initialization
- `firebase_auth` - User authentication
- `cloud_firestore` - Real-time database
- `provider` - State management
- `uuid` - Unique identifier generation

### Security
- Email/password authentication
- Firestore security rules
- Data validation and sanitization
- Secure session management

## Deployment

### Building for Production
```bash
flutter build apk --release
```

### Distribution
- Share the APK file directly
- No app store restrictions
- Works on all Android devices
- Firebase handles all backend services

## Contributing

Feel free to contribute to PixelChat! You can:
- Add new pixel art elements
- Improve the retro design
- Add missing features
- Optimize performance
- Fix bugs

## License

This project is for educational purposes. Not affiliated with WhatsApp Inc.

---

**Enjoy retro-styled real-time chatting! 🎮💬**