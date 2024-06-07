import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_list_model.dart';
import 'package:flutter_client/providers/message_manager_provider.dart';
import 'package:flutter_client/providers/user_list_provider.dart';
import 'package:flutter_client/providers/websocket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> ws = ref.watch(webSocketProvider);
    return switch(ws){
      AsyncValue(:final error?) => ErrorConnection(error: error),
      AsyncValue(:final item)  {
        ref.read(messageManagerProvider(item));
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: const UserListView(),
        );
      }};}
  }
}

class UserListView extends ConsumerWidget {
  const UserListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

class ErrorConnection extends StatelessWidget {
  const ErrorConnection({
    super.key,
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Error"),
      body: Text('Error: $error'),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
}
