import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/routs_constants.dart';
import 'context.dart';
import 'localization/app_language.dart';
import 'localization/app_localization.dart';
import 'locator.dart';
import 'routes.dart';

BuildContext? buildContext;

class App extends StatefulWidget {
  final GlobalKey<NavigatorState> appKey;
  final AppLanguage appLanguage;

  App(this.appKey, this.appLanguage);
  @override
  _AppState createState() => _AppState();

  static _AppState? of(BuildContext context) {
    buildContext = context;
    return context.findAncestorStateOfType<_AppState>();
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    locator<MainContext>().setMainContext(context);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            locale: model.appLocal,
            checkerboardRasterCacheImages: false,
            builder: (context, child) {
              child = MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child!,
              );
              return Directionality(textDirection: TextDirection.ltr, child: child);
            },
            navigatorObservers: [
              locator<RouteObserver<PageRoute>>(),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            navigatorKey: widget.appKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              return PageRouteBuilder(
                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                  return SlideTransition(
                    textDirection: TextDirection.ltr,
                    position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                settings: RouteSettings(arguments: settings.arguments),
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (ctx, an1, an2) => routes[settings.name!]!,
              );
            },
            initialRoute: RoutesConstants.initialRoute,
          );
        }));
  }
}
