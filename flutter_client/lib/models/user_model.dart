class UserModel {
  String username;

  UserModel({required this.username});

  UserModel.fromJson(Map<String, dynamic> json) : username = json['username'];
}
