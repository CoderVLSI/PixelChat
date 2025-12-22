import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat.dart';
import 'auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // User collection
  CollectionReference get _users => _db.collection('users');
  CollectionReference get _chats => _db.collection('chats');
  CollectionReference get _messages => _db.collection('messages');
  CollectionReference get _statuses => _db.collection('statuses');
  CollectionReference get _calls => _db.collection('calls');

  // Create or update user profile
  Future<void> updateUserProfile({
    required String uid,
    required String displayName,
    required String email,
    String? avatar,
    String? status,
    bool isOnline = false,
  }) async {
    await _users.doc(uid).set({
      'displayName': displayName,
      'email': email,
      'avatar': avatar ?? '🙂',
      'status': status ?? 'Hey there! I am using Pixel WatsApp',
      'isOnline': isOnline,
      'lastSeen': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot doc = await _users.doc(uid).get();
    return doc.exists ? doc.data() as Map<String, dynamic>? : null;
  }

  // Get all users (for contacts)
  Stream<QuerySnapshot> getAllUsers() {
    return _users.where('uid', isNotEqualTo: _authService.currentUser?.uid).snapshots();
  }

  // Create or get chat between two users
  Future<DocumentReference> getOrCreateChat(String otherUserId) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) throw 'User not logged in';

    // Check if chat already exists
    QuerySnapshot existingChat = await _chats
        .where('participants', arrayContains: currentUserId)
        .where('participants', arrayContains: otherUserId)
        .get();

    if (existingChat.docs.isNotEmpty) {
      return existingChat.docs.first.reference;
    }

    // Create new chat
    return await _chats.add({
      'participants': [currentUserId, otherUserId],
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get user's chats
  Stream<QuerySnapshot> getUserChats() {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) return Stream.empty();

    return _chats
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  // Send message
  Future<void> sendMessage({
    required String chatId,
    required String content,
    String type = 'text',
  }) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) throw 'User not logged in';

    await _messages.add({
      'chatId': chatId,
      'senderId': currentUserId,
      'content': content,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // Update chat's last message
    await _chats.doc(chatId).update({
      'lastMessage': content,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'lastSenderId': currentUserId,
    });
  }

  // Get messages for a chat
  Stream<QuerySnapshot> getChatMessages(String chatId) {
    return _messages
        .where('chatId', equalsTo: chatId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) return;

    QuerySnapshot unreadMessages = await _messages
        .where('chatId', equalsTo: chatId)
        .where('senderId', isNotEqualTo: currentUserId)
        .where('isRead', equalsTo: false)
        .get();

    WriteBatch batch = _db.batch();
    for (DocumentSnapshot doc in unreadMessages.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // Create status
  Future<void> createStatus({
    required String content,
    String type = 'text',
  }) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) throw 'User not logged in';

    await _statuses.add({
      'userId': currentUserId,
      'content': content,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
      'expiresAt': Timestamp.now().add(const Duration(hours: 24)),
      'viewers': [],
    });
  }

  // Get statuses
  Stream<QuerySnapshot> getStatuses() {
    return _statuses
        .where('expiresAt', isGreaterThan: Timestamp.now())
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Create call record
  Future<void> createCallRecord({
    required String recipientId,
    required CallType callType,
    required CallStatus callStatus,
    Duration? duration,
  }) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) throw 'User not logged in';

    await _calls.add({
      'callerId': currentUserId,
      'recipientId': recipientId,
      'callType': callType.toString(),
      'callStatus': callStatus.toString(),
      'timestamp': FieldValue.serverTimestamp(),
      'duration': duration?.inSeconds,
    });
  }

  // Get call history
  Stream<QuerySnapshot> getCallHistory() {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) return Stream.empty();

    return _calls
        .where('callerId', isEqualTo: currentUserId)
        .orWhere('recipientId', isEqualTo: currentUserId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Update online status
  Future<void> updateOnlineStatus(bool isOnline) async {
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null) return;

    await _users.doc(currentUserId).update({
      'isOnline': isOnline,
      'lastSeen': isOnline ? FieldValue.serverTimestamp() : null,
    });
  }
}