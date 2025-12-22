import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_screen.dart';
import 'themes/pixel_theme.dart';
import 'services/chat_service.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PixelChatApp());
}

class PixelChatApp extends StatelessWidget {
  const PixelChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ChatService()),
      ],
      child: MaterialApp(
        title: 'PixelChat',
        debugShowCheckedModeBanner: false,
        theme: PixelTheme.lightTheme,
        darkTheme: PixelTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const AuthScreen(),
      ),
    );
  }
}