import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:abould_ada/core/services/translation_service.dart';
import 'package:abould_ada/testing/fakes/fake_translation_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TranslationService service;

  setUp(() {
    service = TranslationService(FakeTranslationClient());
  });

  test('buildFromSource fills hindi when user writes english', () async {
    final result = await service.buildFromSource(
      text: 'Buy milk',
      sourceLanguageCode: 'en',
    );
    expect(result, const BilingualText(english: 'Buy milk', hindi: '[Buy milk]'));
  });

  test('buildFromSource fills english when user writes hindi', () async {
    final result = await service.buildFromSource(
      text: 'दूध खरीदें',
      sourceLanguageCode: 'hi',
    );
    expect(
      result,
      const BilingualText(english: '(दूध खरीदें)', hindi: 'दूध खरीदें'),
    );
  });
}
