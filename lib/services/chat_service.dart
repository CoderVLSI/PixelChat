import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat.dart';
import 'database_service.dart';
import 'auth_service.dart';

class ChatService extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  List<Chat> _chats = [];
  List<Map<String, dynamic>> _users = [];
  String? _currentUserId;

  List<Chat> get chats => _chats;
  List<Map<String, dynamic>> get users => _users;

  ChatService() {
    _currentUserId = _authService.currentUser?.uid;
    _initializeListeners();
  }

  void _initializeListeners() {
    if (_currentUserId != null) {
      // Listen for user chats
      _databaseService.getUserChats().listen((snapshot) {
        _processChatsSnapshot(snapshot);
      });

      // Listen for all users (contacts)
      _databaseService.getAllUsers().listen((snapshot) {
        _processUsersSnapshot(snapshot);
      });
    }
  }

  void _processChatsSnapshot(QuerySnapshot snapshot) async {
    List<Chat> chats = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> participants = data['participants'] ?? [];

      // Get the other participant's info
      String otherUserId = participants.firstWhere((id) => id != _currentUserId,
        orElse: () => participants.first);

      Map<String, dynamic>? userData = await _databaseService.getUserData(otherUserId);

      if (userData != null) {
        chats.add(Chat(
          id: doc.id,
          name: userData['displayName'] ?? 'Unknown User',
          avatar: userData['avatar'] ?? '🙂',
          lastMessage: data['lastMessage'] ?? '',
          timestamp: (data['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          unreadCount: 0, // TODO: Calculate actual unread count
          isOnline: userData['isOnline'] ?? false,
        ));
      }
    }

    _chats = chats;
    notifyListeners();
  }

  void _processUsersSnapshot(QuerySnapshot snapshot) {
    List<Map<String, dynamic>> users = [];
    for (var doc in snapshot.docs) {
      users.add({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }
    _users = users;
    notifyListeners();
  }

  Future<void> sendMessage(String chatId, String content) async {
    try {
      await _databaseService.sendMessage(
        chatId: chatId,
        content: content,
      );
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  Future<void> startChat(String userId) async {
    try {
      await _databaseService.getOrCreateChat(userId);
    } catch (e) {
      debugPrint('Error starting chat: $e');
    }
  }

  Future<void> markMessagesAsRead(String chatId) async {
    try {
      await _databaseService.markMessagesAsRead(chatId);
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
    }
  }

  Stream<QuerySnapshot> getChatMessages(String chatId) {
    return _databaseService.getChatMessages(chatId);
  }

  Stream<QuerySnapshot> getStatuses() {
    return _databaseService.getStatuses();
  }

  Stream<QuerySnapshot> getCallHistory() {
    return _databaseService.getCallHistory();
  }

  Future<void> createStatus(String content) async {
    try {
      await _databaseService.createStatus(content: content);
    } catch (e) {
      debugPrint('Error creating status: $e');
    }
  }

  Future<void> createCallRecord({
    required String recipientId,
    required CallType callType,
    required CallStatus callStatus,
    Duration? duration,
  }) async {
    try {
      await _databaseService.createCallRecord(
        recipientId: recipientId,
        callType: callType,
        callStatus: callStatus,
        duration: duration,
      );
    } catch (e) {
      debugPrint('Error creating call record: $e');
    }
  }

  Map<String, dynamic>? getUserById(String userId) {
    try {
      return _users.firstWhere((user) => user['id'] == userId);
    } catch (e) {
      return null;
    }
  }

  void refreshUserList() {
    _currentUserId = _authService.currentUser?.uid;
    _initializeListeners();
  }
}