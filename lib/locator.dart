import 'package:bloc_poc/context.dart';
import 'package:bloc_poc/screens/home_screen/home_bloc.dart';
import 'package:bloc_poc/screens/login_screen/login_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart';

import 'database/database_provider.dart';
import 'localization/app_language.dart';
import 'services/database.service.dart';
import 'services/login_service.dart';
import 'utils/global_observalable.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.pushNewScope();
  locator.registerSingleton<GlobalObservable>(GlobalObservable());
  locator.registerSingleton<DatabaseProvider>(DatabaseProvider());

  locator.registerSingleton<DatabaseService>(DatabaseService());

  locator.registerSingleton<LoginService>(LoginService());
  locator.registerSingleton<LoginBloc>(LoginBloc());
  locator.registerSingleton<HomeBloc>(HomeBloc());
  locator.registerSingleton<MainContext>(MainContext());
  locator.registerSingleton<AppLanguage>(AppLanguage());
  locator.registerSingleton<RouteObserver<PageRoute>>(RouteObserver());
}
