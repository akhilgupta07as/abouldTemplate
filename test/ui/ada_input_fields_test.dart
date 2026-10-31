import 'package:abould_ada/modules/ui_components/widgets/ada_password_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/inputs/ada_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestable(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  group('ADA Input Fields Widget Tests', () {
    testWidgets('AdaTextField updates controller and displays label', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        buildTestable(
          AdaTextField(
            controller: controller,
            label: 'Username',
            hint: 'Enter your username',
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'abould_dev');
      expect(controller.text, 'abould_dev');
    });

    testWidgets('AdaPasswordField toggles obscuring text', (tester) async {
      final controller = TextEditingController(text: 'secret123');
      await tester.pumpWidget(
        buildTestable(
          AdaPasswordField(
            label: 'Password',
            controller: controller,
          ),
        ),
      );

      // Initially password icon is visibility
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tap toggle icon
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      // Should now show visibility_off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('AdaSwitchField toggles value callback', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        buildTestable(
          StatefulBuilder(
            builder: (context, setState) {
              return AdaSwitchField(
                label: 'Dark Mode',
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      );

      expect(find.text('Dark Mode'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(value, isTrue);
    });

    testWidgets('AdaCheckboxField toggles value callback', (tester) async {
      bool checked = false;
      await tester.pumpWidget(
        buildTestable(
          StatefulBuilder(
            builder: (context, setState) {
              return AdaCheckboxField(
                label: 'Accept Terms',
                value: checked,
                onChanged: (v) => setState(() => checked = v ?? false),
              );
            },
          ),
        ),
      );

      expect(find.text('Accept Terms'), findsOneWidget);
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(checked, isTrue);
    });

    testWidgets('AdaDropdownField renders and selects item', (tester) async {
      String? selected = 'A';
      await tester.pumpWidget(
        buildTestable(
          StatefulBuilder(
            builder: (context, setState) {
              return AdaDropdownField<String>(
                label: 'Category',
                value: selected,
                items: const [
                  DropdownMenuItem(value: 'A', child: Text('Option A')),
                  DropdownMenuItem(value: 'B', child: Text('Option B')),
                ],
                onChanged: (v) => setState(() => selected = v),
              );
            },
          ),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
      await tester.tap(find.text('Option A'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Option B').last);
      await tester.pumpAndSettle();

      expect(selected, 'B');
    });
  });
}
