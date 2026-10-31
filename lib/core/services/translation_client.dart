abstract interface class TranslationClient {
  Future<String> translate(
    String text, {
    required String fromLanguageCode,
    required String toLanguageCode,
  });
}
