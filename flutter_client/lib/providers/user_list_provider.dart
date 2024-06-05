import 'package:flutter_client/models/user_list_model.dart';
import 'package:flutter_client/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const UserListModel userListMock = UserListModel(
  users: [
    UserModel(username: ["Emmanuel"]),
    UserModel(username: ["Roland"]),
    UserModel(
      username: ["Serge"],
    )
  ],
);

final userListProvider = Provider((ref) => userListMock);
