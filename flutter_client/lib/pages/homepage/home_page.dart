import 'package:flutter/material.dart';
import 'package:flutter_client/models/user_information_model.dart';
import 'package:flutter_client/pages/homepage/ask_username.dart';
import 'package:flutter_client/providers/user_information_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/default_app_bar.dart';
import 'user_list_loading_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserInformationModel user = ref.watch(userInformationProvider);
    if (user.username.isEmpty) {
      return AskUsername();
    }
    return const Scaffold(
      appBar: DefaultAppBar(title: "Home"),
      body: UserListLoadingPage(),
    );
  }
}
