import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_list_model.dart';
import 'package:flutter_client/providers/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserListModel userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
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
                    final user = userList.users[index].lastUsername;
                    return ListTile(
                      title: Text(user),
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
      ),
    );
  }
}
