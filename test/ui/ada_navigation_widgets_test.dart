import 'package:abould_ada/modules/ui_components/widgets/navigation/ada_navigation_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ADA Navigation Widgets Tests', () {
    testWidgets('AdaAppBar displays title and executes actions', (tester) async {
      bool actionTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AdaAppBar(
              title: 'Dashboard Screen',
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => actionTapped = true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Dashboard Screen'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings));
      expect(actionTapped, isTrue);
    });

    testWidgets('AdaBackButton triggers custom callback', (tester) async {
      bool popped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaBackButton(
              label: 'Go Back',
              onPressed: () => popped = true,
            ),
          ),
        ),
      );

      expect(find.text('Go Back'), findsOneWidget);
      await tester.tap(find.byType(AdaBackButton));
      expect(popped, isTrue);
    });

    testWidgets('AdaBreadcrumb triggers segment tap', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaBreadcrumb(
              segments: const ['Home', 'Catalog', 'Electronics'],
              onSegmentTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Catalog'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);

      await tester.tap(find.text('Catalog'));
      expect(tappedIndex, 1);
    });

    testWidgets('AdaBottomNavigation switches tabs', (tester) async {
      int currentIndex = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: AdaBottomNavigation(
                  currentIndex: currentIndex,
                  onTap: (i) => setState(() => currentIndex = i),
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(currentIndex, 1);
    });
  });
}
