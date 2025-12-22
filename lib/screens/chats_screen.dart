import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';
import '../services/chat_service.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import '../widgets/pixel_avatar.dart';
import 'chat_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIXELCHAT'),
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
            padding: EdgeInsets.zero,
            itemCount: chatService.chats.length,
            itemBuilder: (context, index) {
              final chat = chatService.chats[index];
              return PixelChatTile(
                chat: chat,
                onTap: () {
                  chatService.markMessagesAsRead(chat.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(chat: chat),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        decoration: PixelTheme.pixelButtonDecoration,
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class PixelChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const PixelChatTile({
    Key? key,
    required this.chat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            PixelAvatar(
              emoji: chat.avatar,
              isOnline: chat.isOnline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatTimestamp(chat.timestamp),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: chat.unreadCount > 0
                              ? PixelTheme.primaryGreen
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.isTyping ? 'typing...' : chat.lastMessage,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: chat.isTyping
                                ? PixelTheme.primaryGreen
                                : null,
                            fontStyle: chat.isTyping
                                ? FontStyle.italic
                                : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: PixelTheme.primaryGreen,
                            border: Border.all(
                              color: PixelTheme.darkGreen,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
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
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}