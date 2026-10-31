import 'package:equatable/equatable.dart';

/// User-generated copy stored as English + Hindi in the database.
class BilingualText extends Equatable {
  const BilingualText({
    required this.english,
    required this.hindi,
  });

  final String english;
  final String hindi;

  String forLanguageCode(String languageCode) {
    if (languageCode == 'hi') {
      if (hindi.isNotEmpty) return hindi;
      return english;
    }
    if (english.isNotEmpty) return english;
    return hindi;
  }

  Map<String, dynamic> toFirestoreMap({String? legacyTodonameKey}) {
    final map = <String, dynamic>{
      'english': english,
      'hindi': hindi,
    };
    if (legacyTodonameKey != null) {
      map[legacyTodonameKey] = english.isNotEmpty ? english : hindi;
    }
    return map;
  }

  factory BilingualText.fromFirestore(
    Map<String, dynamic> map, {
    String? legacyField,
  }) {
    final legacy = legacyField != null ? map[legacyField]?.toString() : null;
    final en = map['english']?.toString().trim();
    final hi = map['hindi']?.toString().trim();
    return BilingualText(
      english: (en != null && en.isNotEmpty) ? en : (legacy ?? ''),
      hindi: hi ?? '',
    );
  }

  @override
  List<Object?> get props => [english, hindi];
}
