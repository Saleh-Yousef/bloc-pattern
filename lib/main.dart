import 'package:flutter/material.dart';

import 'app.dart';
import 'localization/app_language.dart';
import 'locator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  AppLanguage appLanguage = locator<AppLanguage>();
  await appLanguage.fetchLocale();

  runApp(App(navigatorKey, appLanguage));
}
