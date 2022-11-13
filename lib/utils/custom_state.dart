import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../context.dart';
import '../constants/db_constans.dart';
import '../locator.dart';
import '../services/database.service.dart';
import 'global_observalable.dart';
import 'mixin.dart';

class SettingsBundel {
  dynamic data;
  String? source;
}

abstract class CustomState<T extends StatefulWidget, B extends Bloc> extends State with LogOut, Screen<B>, WidgetsBindingObserver {
  SettingsBundel settingsBundel = SettingsBundel();
  bool _isPaused = false;

  void onResume();
  void onStart();
  void onPause();
  void onStop();

  Future<T?> pushNamed<T>(BuildContext context, String routeName, {Object? arguments, bool rootNavigator = false}) {
    _isPaused = true;
    onStop();
    locator<MainContext>().setMainContext(context);
    return Navigator.of(context, rootNavigator: rootNavigator).pushNamed<T>(routeName, arguments: arguments).then((value) {
      _isPaused = false;
      settingsBundel.data = value;
      settingsBundel.source = routeName;
      onStart();

      return value;
    });
  }

  Future<T?> pushNamedAndRemoveUntil<T>(BuildContext context, String routeName,
      {Object? arguments, bool rootNavigator = false, required bool Function(Route) route}) {
    _isPaused = true;
    locator<MainContext>().setMainContext(context);

    onStop();
    return Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil<T>(routeName, route, arguments: arguments).then((value) {
      _isPaused = false;
      settingsBundel.data = value;
      settingsBundel.source = routeName;
      onStart();

      return value;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onStart());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }
}

mixin LogOut {
  Future<bool> onLogout(BuildContext context) async {
    locator<GlobalObservable>().onAccountChangeStream.add(GlobalEvent.LOGOUT);
    locator<DatabaseService>().clear(DatabaseConstants.loginTableName);

    await locator.popScope();
    await setupLocator();
    return Future.value(true);
  }
}
