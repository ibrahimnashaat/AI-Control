import 'dart:developer';
import 'dart:io';

import 'package:ai_control/models/class_user_model.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

//import '../../shared/constatnts/constants.dart';
import 'main_states.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStutes> {
  SocialCubit() : super(SocialInitiallStates());

  ///translation2

  static SocialCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    final uId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.uId);
      emit(SocialGetUserSuccessStates());
    }).catchError((e) {
      emit(SocialGetUserErrorStates(e.toString()));
    });
  }

  File? ProfileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagePeckerSuccessStates());
    } else {
      print('No Image Selected!');
      emit(SocialProfileImagePeckerErrorStates());
    }
  }

  File? CoverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(SocialProfileCoverPeckerSuccessStates());
    } else {
      print('No Image Selected!');
      emit(SocialProfileCoverPeckerErrorStates());
    }
  }

  void upLoudProfilImage({
    required String name,
    required String phone,
    required String email,
    required String age,
    required String address,
    required String type, 
    required String typeMember, 
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(ProfileImage!.path).pathSegments.last}")
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          age: age,
          type: type,
          typeMember: typeMember,
          address: address,
          image: value,
        );

        //emit(SocialUpLoudProfileImageSuccessStates());
      }).catchError((e) {
        emit(SocialUpLoudProfileImageErrorStates());
      });
    }).catchError((e) {
      emit(SocialUpLoudProfileImageErrorStates());
    });
  }

  void upLoudProfilCover({
    required String name,
    required String phone,
    required String email,
    required String age,
    required String address,
    required String type,
    required String typeMember,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(CoverImage!.path).pathSegments.last}")
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          type: type,
          typeMember: typeMember,
          age: age,
          address: address,
          cover: value,
        );

        //emit(SocialUpLoudProfileCoverSuccessStates());
      }).catchError((e) {
        emit(SocialUpLoudProfileCoverErrorStates());
      });
    }).catchError((e) {
      emit(SocialUpLoudProfileCoverErrorStates());
    });
  }

/*  void UpdateUserImages({
  required String name,
    required String phone,
    required String email,
    required String bio,
})

  {
    emit(SocialLodingUserUpdateErrorStates());
    if(CoverImage !=null){
      upLoudProfilCover();
    }else if (ProfileImage !=null)
    {
      upLoudProfilImage();
    } else if (CoverImage !=null&&ProfileImage !=null)
    {

    }
    else
    {
      UpdateUser(
        email: email,
        phone: phone,
        name: name,
        bio: bio,
      );
    }

  }*/

  void updateUser({
    required String name,
    required String phone,
    required String email,
    required String age,
    required String address,
    required String type,
    required String typeMember,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      phone: phone,
      name: name,
      bio: bio,
      email: email,
      age: age,
      address: address,
      type: type,
      typeMember: typeMember,
      cover: cover ?? userModel?.cover,
      image: image ?? userModel?.image,
      uId: userModel?.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      emit(SocialUserUpdateErrorStates());
    });
  }

  ///dark & light
  bool isDark = false;

  void changeSocialMode({required bool formSared}) {
    if (formSared != false) {
      isDark = formSared;
      emit(SocialChangeModeState());
    } else {
      isDark = !isDark;
      cachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(SocialChangeModeState());
      });
    }
  }

  ///translation
// void changeLanguage() async {
//   isRtl = !isRtl;
//
//   CacheHelper.saveData(key: 'isRtl' , value: isRtl);
//   String translation = await rootBundle
//       .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
//   setTranslation(
//     translation: translation,
//   );
//
//   emit(ChangeLanguageState());
// }
//
// late TranslationModel translationModel;
//
// void setTranslation({
//   required String translation,
// }) {
//   translationModel = TranslationModel.fromJson(json.decode(
//     translation,
//   ));
//   emit(LanguageLoaded());
// }
}

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
