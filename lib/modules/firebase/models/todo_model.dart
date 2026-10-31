import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  const TodoModel({
    required this.id,
    required this.userref,
    required this.todoname,
    required this.english,
    required this.hindi,
    required this.iscompleted,
    required this.createdAt,
  });

  final String id;
  final String userref;

  /// Legacy primary field (kept in sync with [english] for older clients).
  final String todoname;
  final String english;
  final String hindi;
  final bool iscompleted;
  final DateTime createdAt;

  BilingualText get bilingual =>
      BilingualText(english: english, hindi: hindi);

  String localizedTitle(String languageCode) =>
      bilingual.forLanguageCode(languageCode);

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    final bilingual = BilingualText.fromFirestore(map, legacyField: 'todoname');
    return TodoModel(
      id: map['id']?.toString() ?? '',
      userref: map['userref']?.toString() ?? '',
      todoname: map['todoname']?.toString() ?? bilingual.english,
      english: bilingual.english,
      hindi: bilingual.hindi,
      iscompleted: map['iscompleted'] == true,
      createdAt: _parseCreatedAt(map['createdAt']),
    );
  }

  static DateTime _parseCreatedAt(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return DateTime.now();
  }

  Map<String, dynamic> toCreateMap() => {
        'userref': userref,
        ...bilingual.toFirestoreMap(legacyTodonameKey: 'todoname'),
        'iscompleted': iscompleted,
        'createdAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toUpdateMap({
    BilingualText? text,
    bool? iscompleted,
  }) {
    final data = <String, dynamic>{};
    if (text != null) {
      data.addAll(text.toFirestoreMap(legacyTodonameKey: 'todoname'));
    }
    if (iscompleted != null) data['iscompleted'] = iscompleted;
    return data;
  }
}
