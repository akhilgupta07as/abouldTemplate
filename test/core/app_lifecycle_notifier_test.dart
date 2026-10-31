import 'package:abould_ada/core/services/app_lifecycle_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLifecycleNotifier updates state', () {
    final notifier = AppLifecycleNotifier();
    expect(notifier.state, AppLifecycleState.resumed);
    notifier.update(AppLifecycleState.paused);
    expect(notifier.state, AppLifecycleState.paused);
  });

  test('AppLifecycleObserver forwards lifecycle to notifier', () {
    final notifier = AppLifecycleNotifier();
    final observer = AppLifecycleObserver(notifier);
    observer.didChangeAppLifecycleState(AppLifecycleState.inactive);
    expect(notifier.state, AppLifecycleState.inactive);
  });
}
