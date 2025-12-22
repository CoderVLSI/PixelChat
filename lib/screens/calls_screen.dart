import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import '../widgets/pixel_avatar.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALLS'),
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
          return ListView.builder(
            itemCount: chatService.calls.length,
            itemBuilder: (context, index) {
              final call = chatService.calls[index];
              return _CallTile(call: call);
            },
          );
        },
      ),
      floatingActionButton: Container(
        decoration: PixelTheme.pixelButtonDecoration,
        child: IconButton(
          icon: const Icon(
            Icons.add_call,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _CallTile extends StatelessWidget {
  final dynamic call;

  const _CallTile({
    Key? key,
    required this.call,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PixelAvatar(
              emoji: call.avatar,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: call.status == 'missed' ? Colors.red : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _getCallIcon(call.status),
                        size: 16,
                        color: call.status == 'missed'
                            ? Colors.red
                            : Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        call.type == 'video' ? Icons.videocam : Icons.call,
                        size: 16,
                        color: call.status == 'missed'
                            ? Colors.red
                            : Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          call.duration != null
                              ? '${_formatTimestamp(call.timestamp)} • ${_formatDuration(call.duration)}'
                              : _formatTimestamp(call.timestamp),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: call.status == 'missed'
                                ? Colors.red
                                : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  call.type == 'video' ? Icons.videocam : Icons.call,
                  color: PixelTheme.primaryGreen,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCallIcon(String status) {
    switch (status) {
      case 'missed':
        return Icons.phone_missed;
      case 'incoming':
        return Icons.phone_in_talk;
      case 'outgoing':
        return Icons.phone_forwarded;
      default:
        return Icons.phone;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}