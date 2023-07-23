import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/athlete/main_home_athlete/home_athlete.dart';
import 'package:ai_control/bloc/main_cubit/main_states.dart';
import 'package:ai_control/shared/constatnts/constants.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/main_cubit/mian_cubit.dart';
import 'layouts/login/login.dart';
import 'layouts/main_home/home.dart';
import 'layouts/on_boarding/on_boarding.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  // await cachHelper.init();
  //
  // isRtl = cachHelper.getData(key: 'isRtl') == null ? false : cachHelper.getData(key: 'isRtl');
  // String translation = await rootBundle
  //     .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  await Firebase.initializeApp();
  await cachHelper.init();

  /// dark & light
  await cachHelper.init();
  bool? isDark = cachHelper.getBoolean(key: 'isDark');
  Widget widget;

  var onBoarding = cachHelper.getData(key: 'onBoarding');
  //var token = cachHelper.getData(key: 'token');
  // print(onBoarding);

  uId = cachHelper.getData(key: 'uId');

  if (uId != null) {
    cachHelper.getData(key: 'state') == 'Patient'
        ? widget = Home()
        : widget = HomeAthlete();
  } else {
    if (onBoarding != null) {
      widget = Login();
    } else {
      widget = OnBoarding();
    }
  }
  // if (onBoarding != null){
  //
  //   if (token != null){
  //     widget = Home();
  //   }else{
  //     widget = Login();
  //   }
  //
  // }else{
  //   widget = OnBoarding();
  // }

  runApp(MyApp(
    // isRtl : isRtl ,
    // translation: translation,
    startWidget: widget,
    isDark: false,
  ));
}

class MyApp extends StatelessWidget {
  late final bool onBoarding;
  final Widget startWidget;
  final bool isDark;
  // final bool isRtl;
  // final String translation;

  // required this.isRtl , required this.translation
  MyApp({
    required this.startWidget,
    required this.isDark,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..changeSocialMode(formSared: isDark),
        ),
        // BlocProvider(
        //   create: (BuildContext context) =>
        //       SocialCubit()..changeSocialMode(formSared: isDark),
        // ),
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),

        //     ///translation
        //     BlocProvider(
        // create: (BuildContext context) => SocialCubit()
        // ..setTranslation(translation: translation),
      ],

      /// dark & light

      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return BlocBuilder<SocialCubit, SocialStutes>(
                builder: (context, statemode) => MaterialApp(
                  locale: state.locale,
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (deviceLocale != null &&
                          deviceLocale.languageCode == locale.languageCode) {
                        return deviceLocale;
                      }
                    }

                    return supportedLocales.first;
                  },
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: HexColor('#2888ff'),
                    ),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54),
                      headline4: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    appBarTheme: AppBarTheme(
                      iconTheme:
                          IconThemeData(color: HexColor('#2888ff'), size: 30),
                      color: Colors.white,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.grey[120],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: HexColor('#2888ff'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: HexColor('#2888ff'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#2888ff')),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    primarySwatch: Colors.blue,
                  ),
                  darkTheme: ThemeData(
                    backgroundColor: Colors.black,
                    scaffoldBackgroundColor: Colors.black,
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.black,
                      elevation: 2.0,
                      selectedItemColor: HexColor('#2888ff'),
                      unselectedItemColor: Colors.white.withOpacity(0.5),
                    ),
                    appBarTheme: AppBarTheme(
                      iconTheme:
                          IconThemeData(color: HexColor('#2888ff'), size: 30),
                      color: Colors.black,
                      elevation: 5.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light,
                      ),
                    ),
                    drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      headline4: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.grey[120],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: HexColor('#2888ff'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: HexColor('#2888ff'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#2888ff')),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    primarySwatch: Colors.blue,
                  ),
                  themeMode: SocialCubit.get(context).isDark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  home: startWidget,
                ),
              );
            },
          );
        },
      ),

      ///translation2
      // BlocBuilder<LocaleCubit, ChangeLocaleState>(
      //   builder: (context, state) {
      //     return MaterialApp(
      //       locale: state.locale,
      //       supportedLocales: const [Locale('en'), Locale('ar')],
      //       localizationsDelegates: const [
      //         AppLocalizations.delegate,
      //         GlobalMaterialLocalizations.delegate,
      //         GlobalWidgetsLocalizations.delegate,
      //         GlobalCupertinoLocalizations.delegate
      //       ],
      //       localeResolutionCallback: (deviceLocale, supportedLocales) {
      //         for (var locale in supportedLocales) {
      //           if (deviceLocale != null &&
      //               deviceLocale.languageCode == locale.languageCode) {
      //             return deviceLocale;
      //           }
      //         }
      //
      //         return supportedLocales.first;
      //       },
      //       debugShowCheckedModeBanner: false,
      //       home: const HomePage(),
      //     );
      //   },
      // ),
    );
  }
}
