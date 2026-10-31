import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/testing/helpers/test_bindings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppBindings registers core providers', () async {
    final overrides = await testBindings();
    final container = ProviderContainer(overrides: overrides);

    addTearDown(container.dispose);

    expect(container.read(appConfigProvider).appName, 'ADA');
    expect(container.read(dioApiClientProvider).baseUrl, isNotEmpty);
  });
}
