class Chat {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;

  Chat({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
  });
}

class Message {
  final String id;
  final String chatId;
  final String content;
  final DateTime timestamp;
  final bool isSent;
  final bool isRead;
  final MessageType type;

  Message({
    required this.id,
    required this.chatId,
    required this.content,
    required this.timestamp,
    this.isSent = true,
    this.isRead = false,
    this.type = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  audio,
  video,
  document,
}

class Status {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime timestamp;
  final bool isViewed;

  Status({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
    this.isViewed = false,
  });
}

class Call {
  final String id;
  final String name;
  final String avatar;
  final DateTime timestamp;
  final CallType type;
  final CallStatus status;
  final Duration? duration;

  Call({
    required this.id,
    required this.name,
    required this.avatar,
    required this.timestamp,
    required this.type,
    required this.status,
    this.duration,
  });
}

enum CallType {
  voice,
  video,
}

enum CallStatus {
  missed,
  incoming,
  outgoing,
}