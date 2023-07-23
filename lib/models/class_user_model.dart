class UserModel {
   String? name;
   String? email;
   String? address;
   String? type;
   String? typeMember;
   String? age;
   String? phone;
   String? image;
   String? bio;
   String? cover;
   String? uId;
   bool? isEmailVerified;


  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.address,
    required this.type,
    required this.typeMember,
    required this.phone,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,

  });

  UserModel.fromJson(Map<String ,dynamic > json){

    name = json['name'];
    email = json['email'];
    age = json['age'];
    address = json['address'];
    type = json['type'];
    typeMember = json['typeMember'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];

  }

  Map<String, dynamic>  toMap (){

    return {
      'name' : name,
      'email' : email,
      'age' : age,
      'address' : address,
      'type' : type,
      'typeMember' : typeMember,
      'phone' : phone,
      'uId' : uId,
      'image':image,
      'bio':bio,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };

  }
}
