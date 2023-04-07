class UserModel {
  String? email;
  String? password;
  String? name;
  String? surname;

  UserModel(this.email, this.password, this.name, this.surname);

  factory UserModel.fromJson(Map<dynamic,dynamic> json){

    return UserModel(json["email"] as String,  json["password"] as String,  json["name"] as String , json["surname"] as String,);

  }
}