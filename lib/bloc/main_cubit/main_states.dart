import 'package:flutter/material.dart';

abstract class SocialStutes{
}
class SocialInitiallStates extends SocialStutes{}
class SocialGetUserLoadingStates extends SocialStutes{}
class SocialGetUserSuccessStates extends SocialStutes{}
class SocialGetUserErrorStates extends SocialStutes
{
  final String error;
  SocialGetUserErrorStates(this.error);
}
class ChangBouttomNavStute extends  SocialStutes{}
class SocialNewPostStates extends  SocialStutes{}
//
class SocialProfileImagePeckerSuccessStates extends  SocialStutes{}
class SocialProfileImagePeckerErrorStates extends  SocialStutes{}


//
class SocialProfileCoverPeckerSuccessStates extends  SocialStutes{}
class SocialProfileCoverPeckerErrorStates extends  SocialStutes{}

//
class SocialUpLoudProfileImageSuccessStates extends  SocialStutes{}
class SocialUpLoudProfileImageErrorStates extends  SocialStutes{}
//


class SocialUpLoudProfileCoverSuccessStates extends  SocialStutes{}
class SocialUpLoudProfileCoverErrorStates extends  SocialStutes{}
class SocialUserUpdateErrorStates extends  SocialStutes{}

class SocialUserUpdateLoadingStates extends  SocialStutes{}

//create post
class SocialCreatePostLoadingState extends SocialStutes {}

class SocialCreatePostSuccessState extends SocialStutes {}

class SocialCreatePostErrorState extends SocialStutes {}
class SocialPostImagePeckerSuccessStates extends  SocialStutes{}
class SocialPostImagePeckerErrorStates extends  SocialStutes{}
class SocialRemovePostImageState extends  SocialStutes{}
//
class SocialGetPostsLoadingStates extends SocialStutes{}
class SocialGetPostsSuccessStates extends SocialStutes{}
class SocialGetPostsErrorStates extends SocialStutes
{
  final String error;
  SocialGetPostsErrorStates(this.error);
}
//Likes
class SocialLikePostsSuccessStates extends SocialStutes{}
class SocialLikePostsErrorStates extends SocialStutes
{
  final String error;
  SocialLikePostsErrorStates(this.error);
}

class SocialGetAllUsersLoadingStates extends SocialStutes{}
class SocialGetAllUsersSuccessStates extends SocialStutes{}
class SocialGetAllUsersErrorStates extends SocialStutes
{
  final String error;
  SocialGetAllUsersErrorStates(this.error);
}
//messages

class SocialSendMessageSuccessStates extends SocialStutes{}
class SocialSendMessageErrorStates extends SocialStutes
{
  final String error;
  SocialSendMessageErrorStates(this.error);
}

class SocialGetMessageSuccessStates extends SocialStutes{}
class SocialGetMessageErrorStates extends SocialStutes
{
  final String error;
  SocialGetMessageErrorStates(this.error);
}
class SocialChangeModeState extends SocialStutes{}
///translation2
class ChangeLocaleState extends SocialStutes{
  final Locale locale;
  ChangeLocaleState({
    required this.locale,
  });
}