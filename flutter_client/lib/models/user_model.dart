class UserModel {
  final List<String> username;

  const UserModel({required this.username});

  String get lastUsername => username.last;

  UserModel.fromJson(Map<String, dynamic> json) : username = [json['username']];
}
