import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/login_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/mixin.dart';

class LoginBloc extends Bloc<LoginService> implements BlocLifeCycleInterface {
  StreamController<String> refreshPageStream = StreamController<String>();

  final TextEditingController signInEmailFieldController = TextEditingController();
  final TextEditingController signInPasswordFieldController = TextEditingController();
  String errorEmailMessage = '';
  String errorPasswordMessage = '';
  bool obscurePasswordText = true;

  Future<bool> onPressedLoginButton() async {
    bool validLogin = false;
    errorEmailMessage = '';
    errorPasswordMessage = '';
    if (signInEmailFieldController.text.isNotEmpty && signInPasswordFieldController.text.isNotEmpty) {
      validLogin = await service!.login(userName: signInEmailFieldController.text, password: signInPasswordFieldController.text);
    } else {
      if (signInEmailFieldController.text.isEmpty) {
        errorEmailMessage = 'LoginScreen_PleaseEnterUserName';
        refreshPageStream.sink.add('Refresh');
      }
      if (signInPasswordFieldController.text.isEmpty) {
        errorPasswordMessage = 'LoginScreen_PleaseEnterPassword';
        refreshPageStream.sink.add('Refresh');
      }
    }
    return true;
  }

  void showHidePassword() {
    obscurePasswordText = !obscurePasswordText;
    refreshPageStream.sink.add('Refresh');
  }

  @override
  void pauseSubscription({List? arguments}) {}

  @override
  void resumeSubscription({List? arguments}) {}

  @override
  void startSubscription({List? arguments}) {}

  @override
  void stopSubscription({List? arguments}) {}

  @override
  void clearLoadedData() {}

  @override
  void onAccountSwitch() {}
}
