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

  void updateList(List<String> userList, String username) {
    var userListWithoutUser =
        userList.where((element) => element != username).toList();
    state.users =
        userListWithoutUser.map((e) => UserModel(username: e)).toList();
  }

  void removeUser(String username) {
    if (state.contains(username)) {
      state.removeUser(username);
    }
  }
}
