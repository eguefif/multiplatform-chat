import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_list_model.dart';
import 'package:flutter_client/providers/message_manager_provider.dart';
import 'package:flutter_client/providers/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListView extends ConsumerWidget {
  const UserListView({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(messageManagerProvider(data));
    final UserListModel userList = ref.watch(userListNotifierProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("List of connected users"),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = userList.users[index];
                  return ListTile(
                    title: Text(user.username),
                    onTap: () {
                      Navigator.of(context).pushNamed("/chat");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
