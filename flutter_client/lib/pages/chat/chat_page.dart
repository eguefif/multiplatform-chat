import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key, required this.recipient});

  final String recipient;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(recipient),
      ),
      body: Center(
        child: Chat(recipient: recipient),
      ),
    );
  }
}
