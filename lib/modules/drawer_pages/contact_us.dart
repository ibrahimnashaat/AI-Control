import 'package:ai_control/bloc/main_cubit/mian_cubit.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);


  @override
  State<Contact> createState() => _ContactUsState();
}

class _ContactUsState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
                Icons.brightness_4_outlined
            ),
            onPressed: (){
              SocialCubit.get(context).changeSocialMode(formSared: false);

            },)
        ],
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Ibrahim Nashat',
        textColor: HexColor('#ff2e93'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        email: 'ibrahim.nashat.69@gmail.com',
        // textFont: 'Sail',
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ContactUs(

          cardColor: Color(0xC3FAD2F6),
          textColor: Colors.black54,
          logo: AssetImage('assets/images/ibrahim.jpg'),
          email: 'ibrahim.nashat.69@gmail.com',
          companyName: 'Ibrahim Nashat',
          companyColor: Colors.black54,
          dividerThickness: 2,
          phoneNumber: '+201010492610',
          website: 'https://google.com',
          githubUserName: 'ibrahimnashaat',
          linkedinURL:
          'https://www.linkedin.com/in/ibrahim-nashat-8422401b3/',
          tagLine: 'Flutter Developer',
          taglineColor: Colors.black26,
          twitterHandle: 'twitter.com',
          instagram: 'instagram.com',
          facebookHandle: 'facebook.com'),

    );
  }
}
