import 'package:flutter/material.dart';
import 'package:flutter_client/pages/homepage/ask_username.dart';
import 'package:flutter_client/providers/user_information_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/default_app_bar.dart';
import 'user_list_loading_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String username = "";

  @override
  void initState() {
    super.initState();
  }

  void updateUsername(String value) {
    setState(() {
      username = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (username.isEmpty) {
      return AskUsername(updateUsername: updateUsername);
    }
    return const Scaffold(
      appBar: DefaultAppBar(title: "Home"),
      body: UserListLoadingPage(),
    );
  }
}
