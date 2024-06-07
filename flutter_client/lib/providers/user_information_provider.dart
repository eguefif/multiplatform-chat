import 'package:flutter_client/models/user_information_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_information_provider.g.dart';

@riverpod
class UserInformation extends _$UserInformation {
  @override
  UserInformationModel build() {
    return UserInformationModel();
  }

  void updateUsername(String username) {
    state.username = username;
  }
}
