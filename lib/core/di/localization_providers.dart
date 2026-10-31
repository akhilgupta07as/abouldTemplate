import 'package:abould_ada/core/services/mymemory_translation_client.dart';
import 'package:abould_ada/core/services/translation_client.dart';
import 'package:abould_ada/core/services/translation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final translationClientProvider = Provider<TranslationClient>(
  (ref) => MyMemoryTranslationClient(),
);

final translationServiceProvider = Provider<TranslationService>(
  (ref) => TranslationService(ref.watch(translationClientProvider)),
);
