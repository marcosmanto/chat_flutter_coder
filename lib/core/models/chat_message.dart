class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userImageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  ChatMessage.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        text = map['text'],
        createdAt = DateTime.parse(map['createdAt']),
        userId = map['userId'],
        userName = map['userName'],
        userImageUrl = map['userImageUrl'];

  Map<String, Object> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }
}
