import 'package:flutter/material.dart';
import 'package:flutter_client/pages/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/homepage/home_page.dart';

void main() {
  SocketService socket = SocketService();
  socket.initConnection();
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
      routes: {
        "/": (context) => const HomePage(),
        "/chat": (context) => const HomePage(),
      },
    );
  }
}
