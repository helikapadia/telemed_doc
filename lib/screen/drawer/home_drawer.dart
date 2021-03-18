import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:telemed_doc/util/menu_list.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<MenuList> menuList = <MenuList>[
    MenuList(title: HOME_MENU, icon: Icons.home),
    MenuList(title: PROFILE_MENU, icon: Icons.person),
    MenuList(title: DOCUMENTS_MENU, icon: Icons.file_copy),
    MenuList(title: ANALYSIS_MENU, icon: Icons.analytics_outlined),
    MenuList(title: SETTINGS_MENU, icon: Icons.settings),
    MenuList(title: LOGOUT, icon: Icons.logout),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Theme(
        data: ThemeData.light(),
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          openScreen(menuList[index].title);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(menuList[index].icon),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                menuList[index].title,
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                    itemCount: menuList.length)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openScreen(String name) {
    if (name == PROFILE_MENU) {
      Navigator.pushNamedAndRemoveUntil(
          context, PROFILE_SCREEN, (route) => false);
    } else if (name == SETTINGS_MENU) {
      Navigator.pushNamedAndRemoveUntil(
          context, SETTINGS_SCREEN, (route) => false);
    } else if (name == ANALYSIS_MENU) {
      Navigator.pushNamedAndRemoveUntil(
          context, ANALYSIS_SCREEN, (route) => false);
    } else if (name == DOCUMENTS_MENU) {
      Navigator.pushNamedAndRemoveUntil(
          context, DOCUMENT_DISPLAY_SCREEN, (route) => false);
    } else if (name == HOME_MENU) {
      Navigator.pushNamedAndRemoveUntil(context, HOME_SCREEN, (route) => false);
    } else if (name == LOGOUT) {
      FirebaseAuth.instance.signOut().then((value) async {
        await AppPreference.remove(USER_EMAIL);
        await AppPreference.remove(USER_FULL_NAME);
        await AppPreference.remove(USER_GENDER);

        await Navigator.pushNamedAndRemoveUntil(
            context, LOGIN_ROUTE, (route) => false,
            arguments: false);
      }).catchError((errors) {
        showMessageDialog(errors.message, context);
      });
    }
  }
}
