import 'package:flutter/material.dart';
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

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback),

          // Bounding boxes
          boundingBoxes(results),
        ],
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

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  const StatsRow(this.left, this.right, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}
