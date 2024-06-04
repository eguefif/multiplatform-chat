import 'package:flutter_client/models/user_model.dart';

class UserListModel {
  List<UserModel> users;

  UserListModel({required this.users});

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      users:
          List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))),
    );
  }
}
