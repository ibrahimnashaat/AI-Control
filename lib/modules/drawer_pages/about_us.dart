import 'package:ai_control/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/color.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: mainColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "about us".tr(context),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        "definition".tr(context),
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage:
                            AssetImage('assets/images/about_us/na.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ibrahim Nashat".tr(context),
                        style: TextStyle(
                          fontSize: 20,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/about_us/sa.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ibrahim Elsadat".tr(context),
                        style:
                            TextStyle(color: mainColor, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/about_us/mo.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Mohamed EL-Werdany".tr(context),
                        style:
                            TextStyle(color: mainColor, fontSize: 20),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                     Container(
                       width: 115,
                       height: 115,

                       decoration: BoxDecoration(

                         shape: BoxShape.circle,
                         color: Colors.cyanAccent
                       ),
                       child: ClipOval(
                         child: Image.asset('assets/images/about_us/has.jpg',

                           fit: BoxFit.contain,
                         ),
                       ),
                     ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Hasnaa Tarik".tr(context),
                        style:
                            TextStyle(color: mainColor, fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        
                     backgroundImage: AssetImage('assets/images/about_us/ra.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Rahma Mohamed".tr(context),
                        style:
                            TextStyle(color: mainColor, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
