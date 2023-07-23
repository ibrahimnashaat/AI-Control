import 'package:ai_control/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AboutUsAthlete extends StatefulWidget {
  const AboutUsAthlete({Key? key}) : super(key: key);

  @override
  State<AboutUsAthlete> createState() => _AboutUsAthleteState();
}

class _AboutUsAthleteState extends State<AboutUsAthlete> {
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.red,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "About Us".tr(context),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        "definition".tr(context),
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
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
                  color:Colors.red,
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
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage:
                            AssetImage('assets/images/Amr_Abdellatife.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "D\\\\ Amr Abdellatif".tr(context),
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor('#2888ff'),
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
                        backgroundImage: AssetImage('assets/images/sadat.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ibrahim Elsadat".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
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
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/b.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ahmed Mohamed".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/aaaa.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Apanop Fekry".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
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
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/a.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ibthal Ahmed".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        
                     backgroundImage: AssetImage('assets/images/aa.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Heba Ahmed".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(
                height: 20
              ),
              Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/aaa.jpg'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Mahmoud Yousif".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 56,
                        backgroundImage: AssetImage('assets/images/i.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Amal Othman".tr(context),
                        style:
                            TextStyle(color: HexColor('#2888ff'), fontSize: 20),
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
                        backgroundImage:
                            AssetImage('assets/images/ibrahim.jpg'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ibrahim Nashat".tr(context),
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor('#2888ff'),
                        ),
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
