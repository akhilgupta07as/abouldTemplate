import 'package:abould_ada/app.dart';
import 'package:abould_ada/testing/helpers/test_bindings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('splash to dashboard flow', (tester) async {
    final overrides = await testBindings();

    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const AbouldAdaApp(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pump();

    expect(find.text('Welcome back'), findsOneWidget);
  });
}
