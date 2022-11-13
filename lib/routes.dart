import 'package:bloc_poc/screens/home_screen/home_screen.dart';
import 'package:bloc_poc/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'constants/routs_constants.dart';

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const LoginScreen(),
  RoutesConstants.homeScreen: const HomeScreen(),
};
