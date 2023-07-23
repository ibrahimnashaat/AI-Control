import 'package:ai_control/bloc/main_cubit/mian_cubit.dart';
import 'package:ai_control/shared/constatnts/constants.dart';
import 'package:ai_control/translation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cachHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  ///ده كود ال set data  فى ال sharedpefrance
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }
  ///ده كود ال get data  فى ال sharedpefrance
  static dynamic getData({ required String key }) {
    return sharedPreferences!.get(key);

  }
  ///ده كود ال remove data  فى ال sharedpefrance
  static Future<bool> removeData(String key) async {
    return await sharedPreferences!.remove(key);
  }
  ///dark&light
  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    // if (value is String) return await sharedPreferences!.setString(key, value);
    // if (value is int) return await sharedPreferences!.setInt(key, value);
    // if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setBool(key, value);
  }
  static bool? getBoolean(
      {
        required String key,
      }
      )
  {
    return sharedPreferences?.getBool(key);
  }
///translation
//   TranslationModel appTranslation(context) =>
//       SocialCubit.get(context).translationModel;
//
//   String displayTranslatedText({
//     required BuildContext context,
//     required String ar,
//     required String en,
//   }) => isRtl ? ar : en;
///translation2
// Future<void> cacheLanguageCode(String languageCode) async {
// final sharedPreferences = await SharedPreferences.getInstance();
// sharedPreferences.setString("LOCALE", languageCode);
// }
//
// Future<String> getCachedLanguageCode() async {
// final sharedPreferences = await SharedPreferences.getInstance();
// final cachedLanguageCode = sharedPreferences.getString("LOCALE");
// if (cachedLanguageCode != null) {
// return cachedLanguageCode;
// } else {
// return "en";
// }
// }




}
class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("LOCALE", languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedLanguageCode = sharedPreferences.getString("LOCALE");
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "en";
    }
  }
}
// class LanguageCachHelper{
//   getCachLanguageCode() {Future<void> cachLanguageCode(String languageCode)async{
//     final sharedPreferances = await SharedPreferences.getInstance();
//     sharedPreferances.setString("local",language);
//   }
//   Future<String> getcachLanguageCode(String languageCode)async{
//     final sharedPreferances = await SharedPreferences.getInstance();
//     final cachLanguageCode = sharedPreferances.getString("local");
//     if(cachLanguageCode != null){
//       return cachLanguageCode;
//     } else {
//       return "en";
//     }
//   }}
//
// }