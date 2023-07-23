import 'package:ai_control/athlete/home_pages/download_athlete.dart';
import 'package:ai_control/athlete/home_pages/patient_state_athlete.dart';
import 'package:ai_control/bloc/main_home_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/home_pages/download.dart';
import '../../modules/home_pages/patient_state.dart';

class NeuroCubit extends Cubit<NeuroStates> {
  NeuroCubit() : super(NeuroInitialState());

  static NeuroCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int currentIndexAthlete = 0;

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.health_and_safety,
        ),
        label: 'Health'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.download_sharp,
        ),
        label: 'Download'),
  ];
  List<BottomNavigationBarItem> bottomNavItemsAthlete = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.health_and_safety,
        ),
        label: 'Health'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.download_sharp,
        ),
        label: 'Download'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NeuroBottomNavState());
  }

  void changeBottomNavBarAthlete(int index) {
    currentIndex = index;
    emit(NeuroBottomNavState());
  }

  List<Widget> screens = const [
    Patient(),
    Download(),
  ];
  List<Widget> screensAthlete = const [
    PatientAthlete(),
    DownloadAthlete(),
  ];
}
