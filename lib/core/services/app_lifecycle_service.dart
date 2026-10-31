import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks [AppLifecycleState] for foreground/background handling demos.
class AppLifecycleNotifier extends StateNotifier<AppLifecycleState> {
  AppLifecycleNotifier() : super(AppLifecycleState.resumed);

  void update(AppLifecycleState next) {
    if (state != next) state = next;
  }
}

final appLifecycleProvider =
    StateNotifierProvider<AppLifecycleNotifier, AppLifecycleState>(
  (ref) => AppLifecycleNotifier(),
);

class AppLifecycleObserver extends WidgetsBindingObserver {
  AppLifecycleObserver(this._notifier);

  final AppLifecycleNotifier _notifier;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notifier.update(state);
  }
}
