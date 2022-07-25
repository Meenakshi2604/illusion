import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:illusion/screens/object_detection/box_widget.dart';
import 'package:illusion/services/recognition.dart';
import 'camera_view.dart';

/// [ObjDetPage] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class ObjDetPage extends StatefulWidget {
  const ObjDetPage({Key? key}) : super(key: key);

  @override
  _ObjDetPageState createState() => _ObjDetPageState();
}

class _ObjDetPageState extends State<ObjDetPage> {
  /// Results to draw bounding boxes
  List<Recognition>? results;
  bool flag = false;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    NavBarState.changer.addListener(_listener);
  }

  @override
  void dispose() {
    NavBarState.changer.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (NavBarState.controller.index == 1 && mounted)
      setState(() {
        flag = true;
      });
    else if (flag) {
      setState(() {
        key = GlobalKey();
        flag = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.black,
      body: NavBarState.controller.index == 1
          ? Stack(
              children: <Widget>[
                // Camera View
                CameraView(resultsCallback),

                // Bounding boxes
                //boundingBoxes(results),
              ],
            )
          : Container(
              color: Colours.backgroundColor,
            ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: results
              .map((e) => BoxWidget(
                    result: e,
                  ))
              .toList(),
        ),
      ),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    if (mounted) {
      setState(() {
        this.results = results;
      });
    }
  }
}
