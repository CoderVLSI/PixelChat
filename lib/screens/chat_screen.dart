import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat.dart';
import '../services/chat_service.dart';
import '../themes/pixel_theme.dart';
import '../widgets/pixel_icon.dart';
import '../widgets/pixel_avatar.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final chatService = Provider.of<ChatService>(context, listen: false);
    chatService.sendMessage(widget.chat.id, _messageController.text.trim());
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            PixelAvatar(
              emoji: widget.chat.avatar,
              size: 40,
              showBorder: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.chat.isTyping ? 'typing...' : 'online',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const PixelIcon(Icons.videocam, size: 24, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const PixelIcon(Icons.call, size: 24, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const PixelIcon(Icons.more_vert, size: 24, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Provider.of<ChatService>(context, listen: false)
                  .getChatMessages(widget.chat.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data?.docs ?? [];

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final messageData = message.data() as Map<String, dynamic>;
                    final currentUserId = Provider.of<ChatService>(context, listen: false)
                        ._authService.currentUser?.uid;

                    return _MessageBubble(
                      message: messageData,
                      isSent: messageData['senderId'] == currentUserId,
                    );
                  },
                );
              },
            ),
          ),
          _MessageInput(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isSent;

  const _MessageBubble({
    Key? key,
    required this.message,
    required this.isSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSent) ...[
            PixelAvatar(
              emoji: '👤',
              size: 32,
              showBorder: false,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSent
                    ? PixelTheme.primaryGreen
                    : Theme.of(context).cardTheme.color,
                border: Border.all(
                  color: isSent
                      ? PixelTheme.darkGreen
                      : Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(0),
                  topRight: const Radius.circular(0),
                  bottomLeft: isSent ? const Radius.circular(0) : const Radius.circular(8),
                  bottomRight: isSent ? const Radius.circular(8) : const Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['content'] ?? '',
                    style: TextStyle(
                      color: isSent ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(message['timestamp']),
                    style: TextStyle(
                      color: isSent
                          ? Colors.white.withOpacity(0.7)
                          : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSent) ...[
            const SizedBox(width: 8),
            PixelAvatar(
              emoji: '👤',
              size: 32,
              showBorder: false,
            ),
          ],
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'now';

    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInput({
    Key? key,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
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
            child: IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: const TextStyle(fontSize: 16),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (controller.text.trim().isEmpty) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.attach_file,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {},
              ),
            ),
          ] else ...[
            Container(
              decoration: PixelTheme.pixelButtonDecoration,
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: onSend,
              ),
            ),
          ],
        ],
      ),
    );
  }
}