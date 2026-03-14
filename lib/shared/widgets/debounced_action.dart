import 'package:flutter/foundation.dart';

class DebouncedAction {
  DebouncedAction._();

  static final Map<String, DateTime> _lastExecution = <String, DateTime>{};

  static bool canRun(
    String key, {
    Duration cooldown = const Duration(milliseconds: 800),
  }) {
    final now = DateTime.now();
    final lastTime = _lastExecution[key];
    if (lastTime != null && now.difference(lastTime) < cooldown) {
      return false;
    }
    _lastExecution[key] = now;
    return true;
  }

  @visibleForTesting
  static void reset() {
    _lastExecution.clear();
  }
}
