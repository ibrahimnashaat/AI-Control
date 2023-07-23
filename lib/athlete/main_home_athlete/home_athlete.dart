import 'package:ai_control/bloc/main_cubit/main_states.dart';
import 'package:ai_control/layouts/main_home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/main_cubit/mian_cubit.dart';
import '../../bloc/main_home_cubit/cubit.dart';
import '../../bloc/main_home_cubit/states.dart';

class HomeAthlete extends StatefulWidget {
  const HomeAthlete({Key? key}) : super(key: key);

  @override
  State<HomeAthlete> createState() => _HomeAthleteState();
}

class _HomeAthleteState extends State<HomeAthlete> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NeuroCubit(),
      child: BlocConsumer<NeuroCubit, NeuroStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NeuroCubit.get(context);

          return Scaffold(
            appBar: AppBar(
            
              actions: [
                BlocBuilder<SocialCubit, SocialStutes>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        SocialCubit.get(context)
                            .changeSocialMode(formSared: false);
                      },
                      icon: const Icon(Icons.brightness_4_outlined),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                BlocConsumer<LocaleCubit, ChangeLocaleState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return DropdownButton<String>(
                      value: state.locale.languageCode,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: ['ar', 'en'].map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: HexColor('#2888ff')),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<LocaleCubit>().changeLanguage(newValue);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            body: cubit.screensAthlete[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndexAthlete,
              onTap: (index) {
                cubit.changeBottomNavBarAthlete(index);
              },
              items: cubit.bottomNavItemsAthlete,
              elevation: 10,
            ),
            drawer: const Drawers(),
          );
        },
      ),
    );
  }
}
