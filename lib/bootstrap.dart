import 'package:abould_ada/app.dart';
import 'package:abould_ada/core/bindings/app_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap() async {
  final overrides = await AppBindings.initialize();

  runApp(
    ProviderScope(
      overrides: overrides,
      child: const AbouldAdaApp(),
    ),
  );
}
