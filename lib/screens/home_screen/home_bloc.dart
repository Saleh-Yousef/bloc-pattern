import 'package:flutter/material.dart';

import '../../services/login_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/mixin.dart';

class HomeBloc extends Bloc<LoginService> implements BlocLifeCycleInterface {
  final TextEditingController searchFieldController = TextEditingController();
  final List<String> tabsName = ['HomeScreen_newSettings', 'HomeScreen_notSubscribed', 'HomeScreen_subscriber', 'HomeScreen_All'];

  @override
  void clearLoadedData() {
    // TODO: implement clearLoadedData
  }

  @override
  void onAccountSwitch() {
    // TODO: implement onAccountSwitch
  }

  @override
  void pauseSubscription({List? arguments}) {
    // TODO: implement pauseSubscription
  }

  @override
  void resumeSubscription({List? arguments}) {
    // TODO: implement resumeSubscription
  }

  @override
  void startSubscription({List? arguments}) {
    // TODO: implement startSubscription
  }

  @override
  void stopSubscription({List? arguments}) {
    // TODO: implement stopSubscription
  }
}
