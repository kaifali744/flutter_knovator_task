class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;
  bool isRead;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.isRead = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'isRead': isRead,
    };
  }

  PostModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    bool? isRead,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
    );
  }
}
