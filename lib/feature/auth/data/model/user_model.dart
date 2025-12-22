class UserModel{
  String? id;
  String? email;
  String? password;
  String? userName;
  UserModel({this.id, this.email, this.password, this.userName});

  UserModel.fromJson(Map<String,dynamic> json):this(
    id: json['id'],
    email: json['email'],
    password: json['password'],
    userName: json['userName']
  );
Map<String,dynamic> toJson()=>{
  'id':id,
  'email':email,
  'password':password,
  'userName':userName
};

}


