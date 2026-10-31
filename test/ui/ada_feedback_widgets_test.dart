import 'package:abould_ada/l10n/app_localizations.dart';
import 'package:abould_ada/modules/ui_components/widgets/empty_view.dart';
import 'package:abould_ada/modules/ui_components/widgets/error_view.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_dialogs.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:abould_ada/modules/ui_components/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestable(Widget child) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(body: child),
    );
  }

  group('ADA Feedback & State Widgets Tests', () {
    testWidgets('EmptyView displays title and message', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          const EmptyView(
            title: 'No Data Found',
            message: 'Try searching for something else.',
          ),
        ),
      );

      expect(find.text('No Data Found'), findsOneWidget);
      expect(find.text('Try searching for something else.'), findsOneWidget);
    });

    testWidgets('ErrorView displays message and triggers retry', (tester) async {
      bool retried = false;
      await tester.pumpWidget(
        buildTestable(
          ErrorView(
            message: 'Failed to load feed',
            onRetry: () => retried = true,
          ),
        ),
      );

      expect(find.text('Failed to load feed'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(retried, isTrue);
    });

    testWidgets('LoadingView displays shimmer items and message', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          const LoadingView(
            message: 'Please wait...',
            itemCount: 3,
          ),
        ),
      );

      expect(find.byType(AdaShimmer), findsNWidgets(3));
      expect(find.text('Please wait...'), findsOneWidget);
    });

    testWidgets('AdaDialogs.confirm opens dialog and yields user confirmation', (tester) async {
      bool? confirmed;
      await tester.pumpWidget(
        buildTestable(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  confirmed = await AdaDialogs.confirm(
                    context,
                    title: 'Confirm Action',
                    message: 'Are you sure you want to proceed?',
                    confirmLabel: 'Yes',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Action'), findsOneWidget);
      expect(find.text('Are you sure you want to proceed?'), findsOneWidget);

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
    });
  });
}
