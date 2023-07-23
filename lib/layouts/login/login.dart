import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/athlete/main_home_athlete/home_athlete.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/login_cubit/cubit.dart';
import '../../bloc/login_cubit/states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';
import '../../models/class_user_model.dart';
import '../../shared/components/components.dart';
import '../main_home/home.dart';
import '../register/register.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (BuildContext context, Object? state) {
            if (state is LoginErrorStates) {
              showToast(
                  msg: 'Email or Password not true, please try again.',
                  state: ToastStates.ERORR);

              // cachHelper.saveData(key: 'token', value: false);
            } else if (state is LoginSuccessStates) {
              if (cachHelper.getData(key: "Newtype") == "Patient") {
                  cachHelper.saveData(key: 'uId', value: state.uId).then((value) {
                SocialCubit.get(context).getUserData();
                UserModel? userModel;
                final uId = FirebaseAuth.instance.currentUser?.uid;
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uId)
                    .get()
                    .then((value) {
                  userModel = UserModel.fromJson(value.data()!);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
                  cachHelper.saveData(key: 'type', value: 'user');
                }).catchError((e) {
                  print(e.toString());
                });
              }).catchError((error) {
                print(error.toString());
              });
              }else{
                  cachHelper.saveData(key: 'uId', value: state.uId).then((value) {
                SocialCubit.get(context).getUserData();
                UserModel? userModel;
                final uId = FirebaseAuth.instance.currentUser?.uid;
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uId)
                    .get()
                    .then((value) {
                  userModel = UserModel.fromJson(value.data()!);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeAthlete()),
                      (route) => false);
                  cachHelper.saveData(key: 'type', value: 'user');
                }).catchError((e) {
                  print(e.toString());
                });
              }).catchError((error) {
                print(error.toString());
              });
              }

            
            }
          },
          builder: (BuildContext context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: HexColor('#2888ff'),
                          backgroundImage: AssetImage(
                            'assets/images/3s.png',
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text("Enter Email".tr(context)),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: LoginCubit.get(context).isNotVisible,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter a valid password';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text("passowrd".tr(context)),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(LoginCubit.get(context).suffix),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisability();
                                },
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text("Forget password?".tr(context)))
                          ],
                        ),
                        ConditionalBuilder(
                          condition: state != LoginLoadingStates,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white24)),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                }
                              },
                              color: HexColor('#2888ff'),
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Text("LOGIN".tr(context),
                                  style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              CircularProgressIndicator(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don\\'t have an account?".tr(context),
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                      (route) => false);
                                },
                                child: Text("REGISTER".tr(context)))
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/images/facebook2.png'),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/images/google.png'),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'assets/images/yahoo.png',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
