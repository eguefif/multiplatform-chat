import 'package:flutter/material.dart';
import 'package:flutter_client/pages/chat/chat_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/homepage/home_page.dart';

void main() {
  // SocketService socket = SocketService();
  // socket.initConnection();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/chat') {
            return MaterialPageRoute(
                builder: (context) =>
                    ChatPage(recipient: settings.arguments as String));
          } else {
            return MaterialPageRoute(builder: (context) => const HomePage());
          }
        });
  }
}
