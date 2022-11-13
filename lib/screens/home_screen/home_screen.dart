import 'package:flutter/material.dart';

import '../../constants/routs_constants.dart';
import '../../context.dart';
import '../../localization/app_language.dart';
import '../../localization/app_localization.dart';
import '../../locator.dart';
import '../../utils/custom_state.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends CustomState<HomeScreen, HomeBloc> {
  bool statusOne = false;
  bool statusTwo = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;

    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Text(translate.translate('HomeScreen_Settings')),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
              ),
              title: Text(translate.translate('HomeScreen_Notifications')),
              onTap: () {
                Navigator.pushNamed(context, RoutesConstants.newScreen);
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(
                Icons.language,
              ),
              title: Text(translate.translate('HomeScreen_ChangeLanguage')),
              onTap: () {
                if (locator<AppLanguage>().appLocal.languageCode == 'ar') {
                  locator<AppLanguage>().changeLanguage(const Locale("en"));
                } else {
                  locator<AppLanguage>().changeLanguage(const Locale("ar"));
                }
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(translate.translate('HomeScreen_Logout')),
                  onTap: () async {
                    BuildContext? cachedContext = locator<MainContext>().mainContext;
                    onLogout(context).then((value) async {
                      if (value) {
                        locator<MainContext>().setMainContext(cachedContext);
                        await Navigator.of(context).pushNamedAndRemoveUntil(RoutesConstants.initialRoute, (Route<dynamic> route) => false);
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
      appBar:
          AppBar(automaticallyImplyLeading: false, backgroundColor: Colors.blueGrey, title: Text(translate.translate('HomeScreen_FleetSettings'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: const Color.fromARGB(255, 237, 237, 247)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          size: 20,
                          Icons.menu,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 7,
                    child:
                        // i can use the custom text field here as well with more custmization but for the time saving i created a new one
                        TextField(
                      autofocus: false,
                      keyboardAppearance: Brightness.light,
                      style: const TextStyle(color: Color(0xff191C1F), fontSize: 14),
                      controller: bloc!.searchFieldController,
                      cursorColor: const Color(0xff191C1F),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 237, 237, 247)),
                      onChanged: (text) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i <= 3; i++)
                      Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                              color: i == 3 ? const Color.fromARGB(224, 2, 61, 157) : Colors.transparent),
                          child: Text(
                            translate.translate(bloc!.tabsName[i]),
                            style: TextStyle(color: i == 3 ? Colors.white : Colors.black),
                          )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              for (int i = 0; i <= 4; i++)
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color.fromARGB(255, 214, 231, 229)),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.fire_truck_sharp),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(translate.translate('HomeScreen_ar')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(translate.translate('HomeScreen_Hamza'))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          title: Text(translate.translate('HomeScreen_Services')),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(translate.translate('HomeScreen_serviceOnPlatform')),
                                    ],
                                  ),
                                  Switch(
                                    value: statusOne,
                                    onChanged: (value) {
                                      setState(() {
                                        statusOne = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(translate.translate('HomeScreen_trackingService')),
                                    ],
                                  ),
                                  Switch(
                                    value: statusTwo,
                                    onChanged: (value) {
                                      setState(() {
                                        statusTwo = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onPause() {
    bloc!.pauseSubscription();
  }

  @override
  void onResume() {
    bloc!.resumeSubscription();
  }

  @override
  void onStart() {
    bloc!.startSubscription();
  }

  @override
  void onStop() {
    bloc!.stopSubscription();
  }
}
