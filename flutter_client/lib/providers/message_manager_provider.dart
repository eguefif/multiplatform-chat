import 'dart:convert';

import 'package:flutter_client/providers/user_information_provider.dart';
import 'package:flutter_client/providers/user_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_manager_provider.g.dart';

@riverpod
void messageManager(MessageManagerRef ref, String message) {
  Map<String, dynamic> messageMap = jsonDecode(message);
  String username = ref.read(userInformationProvider).username;
  switch (messageMap['command']) {
    case 'clientlist':
      List<String> content = List<String>.from(messageMap['content'] as List);
      ref.read(userListNotifierProvider.notifier).updateList(content, username);
      break;
  }
}
