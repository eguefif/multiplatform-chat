import 'package:flutter/material.dart';
import 'package:flutter_client/pages/homepage/home_page.dart';
import 'package:flutter_client/providers/websocket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Views/user_list_view.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> ws = ref.watch(webSocketProvider);
    return switch (ws) {
      AsyncValue(:final error?) => ErrorConnectionView(error: error),
      AsyncValue(:final valueOrNull?) => Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: UserListView(data: valueOrNull),
        ),
      _ => Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        )
    };
  }
}
