import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages = <String>[];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void updateChat(String message) {
    setState(() {
      messages.add(message);
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(messages.join("\n")),
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
