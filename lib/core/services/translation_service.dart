import 'package:abould_ada/core/localization/app_locales.dart';
import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:abould_ada/core/services/translation_client.dart';

class TranslationService {
  TranslationService(this._client);

  final TranslationClient _client;

  Future<BilingualText> buildFromSource({
    required String text,
    required String sourceLanguageCode,
  }) async {
    final source = text.trim();
    if (source.isEmpty) {
      return const BilingualText(english: '', hindi: '');
    }

    final from = AppLocales.isSupported(sourceLanguageCode)
        ? sourceLanguageCode
        : 'en';
    final to = from == 'en' ? 'hi' : 'en';

    final translated = await _client.translate(
      source,
      fromLanguageCode: from,
      toLanguageCode: to,
    );

    if (from == 'en') {
      return BilingualText(english: source, hindi: translated);
    }
    return BilingualText(english: translated, hindi: source);
  }
}
