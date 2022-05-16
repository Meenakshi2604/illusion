import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  int _stepIndex = 0;
  final List<String> _texts1 = [
    "Do you wanna know what's in front of you?",
    "Let's take a picture using your camera, shall we?",
    "Launching your camera...",
    "Awesome! Now let's find out what it is...",
    "We think it's a <caption>",
    "Seems you didn't like the picture. Let's try again?"
  ];

  final List<String> _texts2 = [
    "Yes",
    "Sounds good",
    "",
    "Sure",
    "Thank you!",
    "Okay",
  ];

  final List<String> _texts3 = [
    "No",
    "Bad idea",
    "",
    "Nah",
    "Try again",
    "Nope",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SizedBox(
              height: size.height,
              child: Neumorphic(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 80,
                          top: 20,
                          bottom: 20,
                        ),
                        child: Neumorphic(
                          padding: const EdgeInsets.all(20),
                          style: const NeumorphicStyle(
                            depth: -5.0,
                          ),
                          child: Text(
                            _texts1[_stepIndex],
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 24),
                          ),
                        ),
                      ),
                      if (_stepIndex != 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: NeumorphicButton(
                                child: Text(
                                  _texts3[_stepIndex],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black.withOpacity(0.75)),
                                ),
                                onPressed: () async {
                                  if (_stepIndex == 4) {
                                    setState(() {
                                      _stepIndex = 2;
                                    });

                                    final XFile? photo = await _picker
                                        .pickImage(source: ImageSource.camera);

                                    if (photo == null) {
                                      _stepIndex = 4;
                                    }

                                    setState(() {
                                      _stepIndex++;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: NeumorphicButton(
                                child: Text(
                                  _texts2[_stepIndex],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    if (_stepIndex != 2 && _stepIndex < 4) {
                                      _stepIndex++;
                                    } else if (_stepIndex == 4) {
                                      Navigator.pop(context);
                                    } else {
                                      _stepIndex = 2;
                                    }
                                  });

                                  if (_stepIndex == 2) {
                                    final XFile? photo = await _picker
                                        .pickImage(source: ImageSource.camera);

                                    if (photo == null) {
                                      _stepIndex = 4;
                                    }

                                    setState(() {
                                      _stepIndex++;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
