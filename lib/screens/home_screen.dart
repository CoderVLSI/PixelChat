import 'package:flutter/material.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import 'chats_screen.dart';
import 'status_screen.dart';
import 'calls_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const CameraScreen(),
    const ChatsScreen(),
    const StatusScreen(),
    const CallsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerTheme.color!,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const PixelIcon(Icons.camera_alt, size: 24),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: const PixelIcon(Icons.message, size: 24),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: const PixelIcon(Icons.circle, size: 24),
              label: 'Status',
            ),
            BottomNavigationBarItem(
              icon: const PixelIcon(Icons.call, size: 24),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PixelIcon(
              Icons.camera_alt,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              'CAMERA',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tap to capture the moment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}