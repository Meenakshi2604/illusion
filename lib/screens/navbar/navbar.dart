import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/home/home.dart';
import 'package:illusion/screens/home/settings.dart';
import 'package:illusion/screens/object_detection/obj_det.dart';
import 'package:illusion/screens/speech_to_text/stt_page.dart';
import 'package:illusion/screens/text_to_speech/tts_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static PersistentTabController controller =
      PersistentTabController(initialIndex: 0);
  static bool muteHome = false;
  static Changer changer = Changer();

  @override
  void initState() {
    super.initState();
    changer.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      margin: EdgeInsets.all(20),
      padding: NavBarPadding.all(10),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: isDark ? Colors.black12 : Colors.white12,
      navBarHeight: 70,
      bottomScreenMargin: 0,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar:
            isDark ? Colours.darkBackgroundColor : Colours.backgroundColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
      onItemSelected: (index) {
        flutterStt.stop();
        flutterTts.stop();
        changer.notify();
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      ObjDetPage(),
      SpeechToTextPage(),
      TextToSpeechPage(),
      SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary:
            isDark ? Colours.darkPrimaryColor : Colours.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.camera),
        title: ("See"),
        activeColorPrimary:
            isDark ? Colours.darkPrimaryColor : Colours.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.mic),
        title: ("Listen"),
        activeColorPrimary:
            isDark ? Colours.darkPrimaryColor : Colours.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.speaker_3),
        title: ("Speak"),
        activeColorPrimary:
            isDark ? Colours.darkPrimaryColor : Colours.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary:
            isDark ? Colours.darkPrimaryColor : Colours.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class Changer extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
