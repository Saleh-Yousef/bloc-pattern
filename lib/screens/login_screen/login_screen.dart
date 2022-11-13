import 'package:flutter/material.dart';

import '../../constants/routs_constants.dart';
import '../../localization/app_localization.dart';
import '../../shared_widgets/textFields.dart';
import '../../utils/custom_state.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends CustomState<LoginScreen, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    double screenWidthSize = MediaQuery.of(context).size.width;
    return StreamBuilder<String>(
        stream: bloc!.refreshPageStream.stream,
        initialData: null,
        builder: (context, loadingSnapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text(
                translate.translate('LoginScreen_Welcom'),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      translate.translate('LoginScreen_ToKeepConnecting'),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Text(
                    translate.translate('LoginScreen_PleaseLoginWith'),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidthSize / 9.2, right: screenWidthSize / 9.2, top: 16),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: bloc!.signInEmailFieldController,
                          hintText: translate.translate('LoginScreen_UserName'),
                        ),
                        bloc!.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                        bloc!.errorEmailMessage.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                  bloc!.errorEmailMessage == 'incorrect' ? '' : translate.translate(bloc!.errorEmailMessage),
                                  style: const TextStyle(color: Color(0xffE74C4C)),
                                ),
                              )
                            : Container(),
                        bloc!.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidthSize / 9.2, right: screenWidthSize / 9.2),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: bloc!.signInPasswordFieldController,
                          hintText: translate.translate('LoginScreen_Password'),
                          keyboardType: TextInputType.text,
                          obscureText: bloc!.obscurePasswordText,
                          suffixIcon: IconButton(
                            onPressed: () {
                              bloc!.showHidePassword();
                            },
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        bloc!.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                        bloc!.errorPasswordMessage.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                  bloc!.errorPasswordMessage == 'incorrect' ? '' : translate.translate(bloc!.errorPasswordMessage),
                                  style: const TextStyle(color: Color(0xffE74C4C)),
                                ),
                              )
                            : Container(),
                        bloc!.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(
                          width: 2,
                        ),
                        fixedSize: const Size(200, 50)),
                    onPressed: () async {
                      if (await bloc!.onPressedLoginButton()) {
                        Navigator.pushNamed(context, RoutesConstants.homeScreen);
                      }
                    },
                    child: Text(
                      translate.translate('LoginScreen_SIGNIN'),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  @override
  void onStart() {}

  @override
  void onStop() {}
}
