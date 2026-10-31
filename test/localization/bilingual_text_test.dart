import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('forLanguageCode prefers matching locale with fallback', () {
    const text = BilingualText(english: 'Hello', hindi: 'नमस्ते');
    expect(text.forLanguageCode('en'), 'Hello');
    expect(text.forLanguageCode('hi'), 'नमस्ते');
  });

  test('fromFirestore uses legacy todoname when english missing', () {
    final text = BilingualText.fromFirestore(
      {'todoname': 'Legacy', 'hindi': 'पुराना'},
      legacyField: 'todoname',
    );
    expect(text.english, 'Legacy');
    expect(text.hindi, 'पुराना');
  });

  test('toFirestoreMap writes english, hindi, and legacy key', () {
    const text = BilingualText(english: 'A', hindi: 'B');
    final map = text.toFirestoreMap(legacyTodonameKey: 'todoname');
    expect(map['english'], 'A');
    expect(map['hindi'], 'B');
    expect(map['todoname'], 'A');
  });
}
