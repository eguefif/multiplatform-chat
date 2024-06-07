import 'dart:convert';

import 'package:flutter_client/models/user_list_model.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';

@riverpod
class UserListNotifier extends _$UserListNotifier {
  @override
  UserListModel build() {
    return UserListModel();
  }

  void addUserFromJson(String serializedUserList) {
    List<String> userList = jsonDecode(serializedUserList);

    for (String user in userList) {
      if (!state.contains(user)) {
        state.addUser(UserModel(username: user));
      }
    }
  }

  void removeUser(String username) {
    if (state.contains(username)) {
      state.removeUser(username);
    }
  }
}
