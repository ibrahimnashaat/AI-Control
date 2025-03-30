import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/bloc/main_cubit/main_states.dart';
import 'package:ai_control/bloc/main_cubit/mian_cubit.dart';
import 'package:ai_control/shared/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
   String? type ;
   String? typeMember ;
   
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (context, state) {},
      builder: (context, state) {


        var model = SocialCubit.get(context).userModel;
        var image = model?.image;
        var cover = model?.cover;
        nameController.text = model?.name??'loading..';
        bioController.text = model?.bio??'loading..';
        phoneController.text = model?.phone??'loading..';
        emailController.text = model?.email??'loading..';
        type = model?.type??'loading..';
        typeMember = model?.typeMember??'loading..';
        ageController.text = model?.age??'loading..';
        addressController.text = model?.address??'loading..';
        var profileImage = SocialCubit.get(context).ProfileImage;
        var profileCover = SocialCubit.get(context).CoverImage;





        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            leading: IconButton(icon:Icon(Icons.arrow_back_ios_rounded),onPressed: (){
              Navigator.pop(context);
            },),

            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(
                      context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    age: ageController.text,
                    type:type??'',
                    typeMember:typeMember??'',
                    address: addressController.text,
                    bio: bioController.text,
                  );
                },
                child: SizedBox(
                  child: Text(
                    "Update".tr(context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: mainColor
                    ),
                  ),
                  width:60,
                ),

              )

            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,

                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                    image: profileCover == null ?NetworkImage(
                                      '$cover',
                                    ) : FileImage(profileCover) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon:CircleAvatar(
                                    radius: 20,
                                    backgroundColor: mainColor.withOpacity(0.7),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,

                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor:
                              Colors.white,
                              child: CircleAvatar(
                                radius: 56,
                                backgroundColor: Colors.black12,
                                backgroundImage:profileImage == null ? NetworkImage('$image') : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon:CircleAvatar(
                                  radius: 20,
                                  backgroundColor: mainColor.withOpacity(0.7),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 2,
                  ),

                  Text(
                    '${model?.name??'loading..'}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${model?.bio??'loading..'}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  if (SocialCubit.get(context).CoverImage != null || SocialCubit.get(context).ProfileImage != null )
                    Row(
                      children: [
                        if(SocialCubit.get(context).CoverImage != null)

                          Expanded(
                            child:  Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: (){
                                      SocialCubit.get(context).upLoudProfilCover(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          age: ageController.text,
                                          type:type ??'', 
                                          typeMember:typeMember ??'', 
                                          address: addressController.text,
                                          bio: bioController.text);
                                    },
                                    child: Text(
                                      "Update Cover".tr(context),
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    style: OutlinedButton.styleFrom(

                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                  ),
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                  SizedBox(
                                    height: 1,
                                  ),
                                if(state is SocialUserUpdateLoadingStates)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),



                        SizedBox(
                          width: 2,
                        ),
                        if(SocialCubit.get(context).ProfileImage != null)

                          Expanded(
                            child:  Column(
                              children: [
                                OutlinedButton(
                                  onPressed: (){
                                    SocialCubit.get(context).upLoudProfilImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        age: ageController.text,
                                        type:type??'',
                                        typeMember:typeMember??'',
                                        address: addressController.text,
                                        bio: bioController.text);
                                  },
                                  child: Text(
                                    "Update Image".tr(context),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size(100, 50),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                ),
                                if(state is SocialUserUpdateLoadingStates)
                                  SizedBox(
                                    height: 1,
                                  ),
                                if(state is SocialUserUpdateLoadingStates)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),


                      ],
                    ),
                  if (SocialCubit.get(context).CoverImage != null || SocialCubit.get(context).ProfileImage != null )
                    SizedBox(
                      height: 6,
                    ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "User Name".tr(context),
                        style: Theme.of(context).textTheme.bodyLarge,),
                      prefixIcon: Icon(

                        Icons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "BIO".tr(context),
                        style: Theme.of(context).textTheme.bodyLarge,),
                      prefixIcon: Icon(
                        Icons.info_outline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "phone".tr(context),
                        style: Theme.of(context).textTheme.bodyLarge,),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "e-mail".tr(context),
                        style: Theme.of(context).textTheme.bodyLarge,),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
