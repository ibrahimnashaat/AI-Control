import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:ai_control/modules/home_pages/result.dart';
import 'package:ai_control/modules/real_time_graph/real_time_graph.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';

import '../../app_localizations.dart';
import 'dl_model/test_result.dart';


class Patient extends StatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  bool isLive = false;
  final controller = ScreenshotController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDark = !cachHelper.getData(key: 'isDark');
    return Stack(
      children: [
        isDark
            ? Container()
            : Image(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 96.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                        color: HexColor('#2888ff'),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 6, top: 2),
                              child: Text(
                                "Good Morning!".tr(context),
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 6, right: 6, bottom: 2),
                              child: Text(
                                "please connect the EMG device before you click on the start button!"
                                    .tr(context),
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // isLive
                  //     ? Expanded(
                  //     flex: 5,
                  //     child: MyHomePage()
                  // )
                  //     : Expanded(
                  //   flex: 5,
                  //   child: Image.asset(
                  //     'assets/images/12.gif',
                  //   ),
                  // ),

                  SizedBox(height: 3.h),

                  isLive
                      ? Expanded(
                          child: Screenshot(
                            controller: controller,
                            child: MyHomePage(),
                          ),
                        )
                      : Expanded(
                          child: Image.asset(
                            'assets/images/12.gif',
                          ),
                        ),

                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    height: 32.h,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              elevation: 8,
                              minWidth: 120,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.blue)),
                              onPressed: () {



                                setState(() {
                                  isLive = true;
                                });

                                // it takes screen shot of graphe widget and store it in firebase storage.

                                // controller.capture(delay: const Duration(seconds: 12)).then((capturedImage) async {
                                //   await FirebaseStorage.instance.ref('order').child('orders$count.jpg').putData(capturedImage!);
                                //
                                // }).catchError((error){
                                //   if (kDebugMode) {
                                //     print(error.toString());
                                //   }
                                // });
                              },
                              color: HexColor('#2888ff'),
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                "start".tr(context),
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            // Text(
                            //   '|',
                            //   style: TextStyle(
                            //       fontSize: 36,
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.grey),
                            // ),
                            MaterialButton(
                              elevation: 8,
                              minWidth: 120,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.redAccent)),
                              onPressed: () {
                                setState(() {
                                  isLive = false;
                                });
                              },
                              color: Colors.red,
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                "stop".tr(context),
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  // height: 20.h,
                                  // width: 20.h,
                                  height: size.height * 0.2,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: HexColor('#2888ff').withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    result()));
                                      },
                                      child: Icon(
                                        Icons.accessibility_new,
                                        color: HexColor('#2888ff'),
                                      ),
                                    ),
                                    Text(
                                      "result".tr(context),
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                height: size.height * 0.2,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: HexColor('#2888ff').withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      onPressed: () async {
                                        final image =
                                            await controller.capture();
                                        if (image == null) return;
                                        await saveImage(image);
                                      },
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: HexColor('#2888ff'),
                                      ),
                                    ),
                                    Text(
                                      "Sc.Shot".tr(context),
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // MaterialButton(
                            //   minWidth: 120,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       side: BorderSide(color: Colors.redAccent)),
                            //   onPressed: () {
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  result()));
                            //   },
                            //
                            //   color: Colors.orange,
                            //   textColor: Theme.of(context).scaffoldBackgroundColor,
                            //   child: Text(
                            //       "result".tr(context)
                            //
                            //       , style: Theme.of(context).textTheme.headline4),
                            // ),
                            // Text(
                            //   '|',
                            //   style: TextStyle(
                            //       fontSize: 36,
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.grey),
                            // ),
                            // MaterialButton(
                            //   minWidth: 120,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       side: BorderSide(color: Colors.redAccent)),
                            //   onPressed: () async{
                            //     final image= await controller.capture();
                            //     if(image==null)
                            //       return  ;
                            //     await saveImage(image);
                            //   },
                            //   color: Colors.blue,
                            //   textColor: Theme.of(context).scaffoldBackgroundColor,
                            //   child: Text(
                            //       "Sc.Shot".tr(context)
                            //       , style: Theme.of(context).textTheme.headline4),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final image = File('${directory.path}/flutter.png');
    // image.writeAsBytesSync(bytes);
    // await Share.share([image.path]);
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }
}
