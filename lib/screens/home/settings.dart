import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          isDark ? Colours.darkBackgroundColor : Colours.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.settings,
                        color:
                            isDark ? Colours.darkTextColor : Colours.textColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: isDark
                              ? Colours.darkTextColor
                              : Colours.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: assistantOn
                                ? isDark
                                    ? Colors.blue.withOpacity(0.5)
                                    : Colors.blue.withOpacity(0.75)
                                : Colors.blueGrey,
                          ),
                          child: Icon(
                            assistantOn
                                ? CupertinoIcons.mic
                                : CupertinoIcons.mic_off,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "Voice Assistant",
                        style: TextStyle(
                          fontSize: size.height * 0.018,
                          color: isDark
                              ? Colours.darkTextColor
                              : Colours.textColor,
                        ),
                      ),
                      Spacer(),
                      FlutterSwitch(
                        activeText: "",
                        inactiveText: "",
                        width: 50.0,
                        height: 30.0,
                        toggleSize: 20.0,
                        value: assistantOn,
                        borderRadius: 30.0,
                        padding: 4.0,
                        showOnOff: true,
                        onToggle: (val) async {
                          await (await SharedPreferences.getInstance())
                              .setBool('assistantOn', val);
                          setState(() {
                            assistantOn = val;
                          });
                          NavBarState.changer.notify();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.orange.withOpacity(0.75)
                                : Colors.deepOrangeAccent.withOpacity(0.75),
                          ),
                          child: Icon(
                            isDark
                                ? CupertinoIcons.moon_fill
                                : CupertinoIcons.sun_max_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "Dark Mode",
                        style: TextStyle(
                          fontSize: size.height * 0.018,
                          color: isDark
                              ? Colours.darkTextColor
                              : Colours.textColor,
                        ),
                      ),
                      Spacer(),
                      FlutterSwitch(
                        activeText: "",
                        inactiveText: "",
                        width: 50.0,
                        height: 30.0,
                        toggleSize: 20.0,
                        value: isDark,
                        borderRadius: 30.0,
                        padding: 4.0,
                        showOnOff: true,
                        onToggle: (val) async {
                          await (await SharedPreferences.getInstance())
                              .setBool('isDark', val);
                          setState(() {
                            isDark = val;
                          });
                          NavBarState.changer.notify();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      launchURL("mailto:illusion@gmail.com");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.indigoAccent.withOpacity(0.25)
                                  : Colors.indigoAccent.withOpacity(0.75),
                            ),
                            child: Icon(
                              CupertinoIcons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: isDark
                                ? Colours.darkTextColor
                                : Colours.textColor,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                launchURL("mailto:illusion@gmail.com");
                              },
                              child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.04,
                              )),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Icon(
                              CupertinoIcons.forward,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      launchURL("http://www.illusion.com/");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.cyan.withOpacity(0.25)
                                  : Colors.cyan.withOpacity(0.75),
                            ),
                            child: Icon(
                              CupertinoIcons.info,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Text(
                          "About Us",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: isDark
                                ? Colours.darkTextColor
                                : Colours.textColor,
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Icon(
                              CupertinoIcons.forward,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    launchURL("http://www.illusion.com");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.green.withOpacity(0.25)
                                  : Colors.green.withOpacity(0.75),
                            ),
                            child: Icon(
                              CupertinoIcons.doc,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Text(
                          "Terms and Conditions",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: isDark
                                ? Colours.darkTextColor
                                : Colours.textColor,
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Icon(
                              CupertinoIcons.forward,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    launchURL("http://www.illusion.com/privacy");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.red.withOpacity(0.25)
                                  : Colors.red.withOpacity(0.75),
                            ),
                            child: Icon(
                              CupertinoIcons.eye_slash,
                              color: Color.fromARGB(255, 242, 242, 242),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: isDark
                                ? Colours.darkTextColor
                                : Colours.textColor,
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Icon(
                              CupertinoIcons.forward,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
