import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SETTINGS",
                    style: TextStyle(
                      fontSize: 30,
                    ),
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
                            color: Colours.primaryColor,
                          ),
                          child: Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: 22,
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
                            color: Colours.primaryColor,
                          ),
                          child: Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: 22,
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
                            color: Colours.primaryColor,
                          ),
                          child: Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: 22,
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
                            color: Colours.primaryColor,
                          ),
                          child: Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: 22,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
