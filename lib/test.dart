import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  late Timer _timer;
  int _start = 0;
  int _startTwo = 61;

  void increasingStartTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start > 60) {
            timer.cancel();
          } else {
            _start = _start + 1;
          }
        },
      ),
    );
  }

  void decreasingStartTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_startTwo < 0) {
            timer.cancel();
          } else {
            _startTwo = _startTwo - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screenshot Demo App"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  Text("Decreasing Timer : "),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 5.0),
                        color: Colors.amberAccent,
                      ),
                      child: Text(_startTwo.toString())),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Increasing Timer : "),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 5.0),
                        color: Colors.amberAccent,
                      ),
                      child: Text("$_start")),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                increasingStartTimer();
                decreasingStartTimer();
              },
              child: Text("start"),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _start = 0;
                    _startTwo = 61;
                  });
                },
                child: Text("Refresh")),
            ElevatedButton(
              child: Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                Future.delayed(const Duration(seconds: 1), () async {
                  while (count != 9) {
                    screenshotController
                        .capture(delay: Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      ShowCapturedWidget(context, capturedImage!);
                      await FirebaseStorage.instance
                          .ref('order')
                          .child('orders$count.jpg')
                          .putData(capturedImage);
                      Timer(Duration(seconds: 3), () {});
                    }).catchError((onError) {
                      print('kill it$onError');
                    });

                    // Check for existing storage permission

                    count++;
                  }
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Capture An Invisible Widget',
              ),
              onPressed: () {
                var container = Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 5.0),
                      color: Colors.pink,
                    ),
                    child: Text(
                      "This is an invisible widget",
                      style: Theme.of(context).textTheme.headline6,
                    ));

                screenshotController
                    .captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                  _saved(capturedImage);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  _saved(image) async {
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
    print(result);
  }
}
