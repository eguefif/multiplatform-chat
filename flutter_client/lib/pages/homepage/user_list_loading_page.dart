import 'package:flutter/material.dart';
import 'package:flutter_client/providers/websocket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Views/user_list_view.dart';
import 'error_connection_view.dart';

class UserListLoadingPage extends ConsumerWidget {
  const UserListLoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> ws = ref.watch(webSocketProvider);
    return switch (ws) {
      AsyncValue(:final error?) => ErrorConnectionView(error: error),
      AsyncValue(:final valueOrNull?) => UserListView(data: valueOrNull),
      _ => const Center(
          child: CircularProgressIndicator(),
        )
    };
  }
}
