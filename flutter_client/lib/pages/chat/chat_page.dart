import 'package:flutter/material.dart';
import 'package:flutter_client/providers/conversations_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ConversationsModel conversations = ref.watch(conversationsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(conversations.currentRecipient),
      ),
      body: const Center(
        child: Chat(),
      ),
    );
  }
}
