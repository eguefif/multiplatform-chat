import 'package:flutter/material.dart';
import 'package:flutter_client/providers/conversations_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({
    super.key,
    required this.recipient,
  });

  final String recipient;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void updateChat(String message) {
    setState(() {
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String conversation = ref
        .watch(conversationsNotifierProvider)
        .getConversation(widget.recipient);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(conversation),
          ),
          TextField(
            controller: _controller,
            onSubmitted: (String value) async {
              updateChat(value);
            },
            decoration: const InputDecoration(
              hintText: 'Type a message',
              icon: Icon(Icons.send),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
