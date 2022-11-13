import 'dart:async';
import 'dart:ui';

class GlobalObservable {
  StreamController<GlobalEvent> onAccountChangeStream = StreamController<GlobalEvent>.broadcast();

  StreamController<AppLifecycleState> appLifecycleStateStream = StreamController<AppLifecycleState>.broadcast();
  StreamController<String> rebuildTextLanguage = StreamController<String>.broadcast();
}

enum GlobalEvent { LOGOUT }
