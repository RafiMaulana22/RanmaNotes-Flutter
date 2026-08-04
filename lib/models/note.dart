class Note {
  final int? id;
  final String title;
  final String content;
  final String createdAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  /// Convert Note object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt,
    };
  }

  /// Create Note object from Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  /// Copy object with new values
  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
