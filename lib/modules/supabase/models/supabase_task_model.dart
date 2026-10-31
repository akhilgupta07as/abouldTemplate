class SupabaseTaskModel {
  const SupabaseTaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  factory SupabaseTaskModel.fromMap(Map<String, dynamic> map) {
    final legacyTitle = map['title']?.toString().trim();
    final english = map['english']?.toString().trim() ?? '';
    final hindi = map['hindi']?.toString().trim() ?? '';
    final title = (legacyTitle != null && legacyTitle.isNotEmpty)
        ? legacyTitle
        : (english.isNotEmpty ? english : hindi);

    return SupabaseTaskModel(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      title: title,
      isCompleted: map['is_completed'] == true,
      createdAt: _parseDate(map['created_at']),
    );
  }

  static DateTime _parseDate(Object? value) {
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value)?.toLocal() ?? DateTime.now();
    }
    return DateTime.now();
  }

  Map<String, dynamic> toInsertMap({
    required String userId,
    required String title,
  }) {
    return {
      'user_id': userId,
      'title': title,
      'is_completed': false,
    };
  }
}
