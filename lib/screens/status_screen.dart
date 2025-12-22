import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import '../widgets/pixel_avatar.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STATUS'),
        actions: [
          IconButton(
            icon: const PixelIcon(Icons.search, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const PixelIcon(Icons.more_vert, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ChatService>(
        builder: (context, chatService, child) {
          return ListView(
            children: [
              const _MyStatusTile(),
              const _Divider(),
              const _RecentUpdatesHeader(),
              ...chatService.statuses
                  .where((status) => status.userId != 'current')
                  .map((status) => _StatusTile(status: status)),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        decoration: PixelTheme.pixelButtonDecoration,
        child: IconButton(
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _MyStatusTile extends StatelessWidget {
  const _MyStatusTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              PixelAvatar(
                emoji: '🙂',
                showBorder: false,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: PixelTheme.primaryGreen,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Status',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to add status update',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentUpdatesHeader extends StatelessWidget {
  const _RecentUpdatesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).cardTheme.color,
      child: Text(
        'RECENT UPDATES',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: PixelTheme.primaryGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  final dynamic status;

  const _StatusTile({
    Key? key,
    required this.status,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: status.isViewed
                      ? Colors.grey
                      : PixelTheme.primaryGreen,
                  width: 3,
                ),
              ),
              child: PixelAvatar(
                emoji: status.userAvatar,
                size: 50,
                showBorder: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.userName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(status.timestamp),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
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