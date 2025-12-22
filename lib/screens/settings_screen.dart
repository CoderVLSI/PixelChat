import 'package:flutter/material.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import '../widgets/pixel_avatar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _ProfileHeader(),
          const _Divider(),
          _SettingsSection(
            title: 'ACCOUNT',
            items: [
              _SettingsTile(
                icon: Icons.key,
                title: 'Privacy',
                subtitle: 'Block contacts, disappearing messages',
              ),
              _SettingsTile(
                icon: Icons.lock,
                title: 'Security',
                subtitle: 'Security notifications, code change',
              ),
              _SettingsTile(
                icon: Icons.data_usage,
                title: 'Data and storage usage',
                subtitle: 'Network usage, storage usage',
              ),
            ],
          ),
          const _Divider(),
          _SettingsSection(
            title: 'APPEARANCE',
            items: [
              _ThemeTile(),
              _SettingsTile(
                icon: Icons.wallpaper,
                title: 'Wallpaper',
                subtitle: 'Change chat wallpaper',
              ),
            ],
          ),
          const _Divider(),
          _SettingsSection(
            title: 'MORE',
            items: [
              _SettingsTile(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Message, group & call tones',
              ),
              _SettingsTile(
                icon: Icons.help_outline,
                title: 'Help',
                subtitle: 'Help center, contact us, privacy policy',
              ),
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Version 1.0.0',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          PixelAvatar(
            emoji: '🙂',
            size: 64,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pixel User',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Gaming is life! 🎮',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerTheme.color!,
                width: 2,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.qr_code,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).cardTheme.color,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: PixelTheme.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerTheme.color!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
              ),
              child: PixelIcon(
                icon,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeTile extends StatefulWidget {
  const _ThemeTile({Key? key}) : super(key: key);

  @override
  State<_ThemeTile> createState() => _ThemeTileState();
}

class _ThemeTileState extends State<_ThemeTile> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerTheme.color!,
                width: 2,
              ),
            ),
            child: const PixelIcon(
              Icons.palette,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  isDarkMode ? 'Dark' : 'Light',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}