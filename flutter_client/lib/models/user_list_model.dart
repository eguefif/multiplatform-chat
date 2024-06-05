import 'package:flutter_client/models/user_model.dart';

class UserListModel {
  final List<UserModel> users;

  const UserListModel({required this.users});

  int get length => users.length;

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      users:
          List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))),
    );
  }
}
