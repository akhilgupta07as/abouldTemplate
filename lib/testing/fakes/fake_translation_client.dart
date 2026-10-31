import 'package:abould_ada/core/services/translation_client.dart';

/// Deterministic translations for tests (no network).
class FakeTranslationClient implements TranslationClient {
  @override
  Future<String> translate(
    String text, {
    required String fromLanguageCode,
    required String toLanguageCode,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return '';
    if (fromLanguageCode == toLanguageCode) return trimmed;
    if (toLanguageCode == 'hi') return '[$trimmed]';
    return '($trimmed)';
  }
}
