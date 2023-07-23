import 'dart:io';

import 'package:ai_control/modules/home_pages/indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../shared/local/cach_helper/cach_helper.dart';

class result extends StatefulWidget {
  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  late File pickedImage;
  bool isImageLoaded = false;
  late List result;
  String confidence = "";
  String name = "";
  String numbers = "";

  double value = 0.0;
  int value1 = 0;

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
    });
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
    print("Result after loading model:$resultant");
  }

  applyModelOnImage(File file) async {
    try {
      var res = await Tflite.runModelOnImage(
          path: file.path,
          numResults: 2,
          threshold: .5,
          imageMean: 127.5,
          imageStd: 127.5);
      setState(() {
        result = res!;
        String str = result[0]["label"];
        name = str.substring(0);
        cachHelper.saveData(key: 'name', value: name);
        value = result[0]['confidence'] * 10.0;
        value1 = value.toInt();
        value1 >= 100
            ? value1 = value1 ~/ 10
            : value1 <= 10
                ? value1 = value1 * 10
                : value1 = value1;
        cachHelper.saveData(key: 'persentage', value: value1);
        confidence = result != null
            ? "${(result[0]['confidence'] * 100.0).toString().substring(0, 2)}%"
            : "";

        print(value);
        print(value1);
        print(result);
        print(confidence);
      });
    } catch (error) {
      print('error 2');
    }
  }

  @override
  void initState() {
    loadMyModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TFLite Demo'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(height: 30),

            isImageLoaded
                ? Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(pickedImage.path)),
                              fit: BoxFit.contain)),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 4.h,
            ),
            //  isImageLoaded ? Text("Name : $name \n Confidence ") : Container(),

            isImageLoaded
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 30.h,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: HexColor('#2888ff').withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Column(
                        children: [
                          CircularIndicator(
                            value: value1,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 22.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFromGallery();
        },
        child: Icon(Icons.photo_album),
      ),
    );
  }
}
