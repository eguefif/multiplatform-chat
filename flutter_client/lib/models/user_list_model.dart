import 'package:flutter_client/models/user_model.dart';

class UserListModel {
  List<UserModel> users = [];

  int get length => users.length;

  void addUser(UserModel user) {
    users.add(user);
  }

  void removeUser(String username) {
    users.removeWhere((user) => user.username == username);
  }

  bool contains(String username) {
    final test = users.where((user) => user.username == username);
    return test.isNotEmpty;
  }
}
