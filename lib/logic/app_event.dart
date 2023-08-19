import 'dart:async';

import 'package:event_bus/event_bus.dart';


EventBus appEvent = EventBus();

class AppEventOnce<T> {
  late StreamSubscription subscription;
  void on(void onData(T event)) {
    subscription = appEvent.on<T>().listen((event) {
      subscription.cancel();
      onData(event);
    });
  }
}
