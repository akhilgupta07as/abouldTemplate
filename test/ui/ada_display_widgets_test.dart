import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/display/ada_avatar.dart';
import 'package:abould_ada/modules/ui_components/widgets/display/ada_display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ADA Display Widgets Tests', () {
    testWidgets('AdaCard handles tap callback and renders children', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaCard(
              onTap: () => tapped = true,
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      await tester.tap(find.text('Card Content'));
      expect(tapped, isTrue);
    });

    testWidgets('AdaBadge displays label with icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaBadge(
              label: 'Verified',
              icon: Icons.check,
              color: Colors.green,
            ),
          ),
        ),
      );

      expect(find.text('Verified'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('AdaRatingBar triggers change callback', (tester) async {
      double currentRating = 3.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AdaRatingBar(
                  value: currentRating,
                  onChanged: (r) => setState(() => currentRating = r),
                );
              },
            ),
          ),
        ),
      );

      final stars = find.byType(IconButton);
      expect(stars, findsNWidgets(5));

      // Tap 5th star
      await tester.tap(stars.at(4));
      await tester.pumpAndSettle();
      expect(currentRating, 5.0);
    });

    testWidgets('AdaAvatar renders initials when image is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaAvatar(name: 'Emily Smith'),
          ),
        ),
      );

      expect(find.text('ES'), findsOneWidget);
    });
  });
}
