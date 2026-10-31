import 'package:abould_ada/core/services/translation_client.dart';
import 'package:dio/dio.dart';

/// Free tier translation (no API key). Suitable for demos; swap for production API.
class MyMemoryTranslationClient implements TranslationClient {
  MyMemoryTranslationClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<String> translate(
    String text, {
    required String fromLanguageCode,
    required String toLanguageCode,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return '';
    if (fromLanguageCode == toLanguageCode) return trimmed;

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.mymemory.translated.net/get',
        queryParameters: {
          'q': trimmed,
          'langpair': '$fromLanguageCode|$toLanguageCode',
        },
        options: Options(
          receiveTimeout: const Duration(seconds: 12),
          sendTimeout: const Duration(seconds: 12),
        ),
      );
      final data = response.data;
      final status = data?['responseStatus'];
      if (status == 200 || status == '200') {
        final translated =
            data?['responseData']?['translatedText']?.toString().trim();
        if (translated != null && translated.isNotEmpty) {
          return translated;
        }
      }
    } catch (_) {
      // Fall through to source text.
    }
    return trimmed;
  }
}
