import 'package:flutter/material.dart';
import 'package:flutter_client/providers/user_information_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/default_app_bar.dart';

class AskUsername extends ConsumerWidget {
  AskUsername({super.key, required this.updateUsername});
  final TextEditingController controller = TextEditingController();
  final void Function(String username) updateUsername;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Username selection"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Please enter your username"),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                onChanged: (value) {},
                onSubmitted: (value) {
                  ref
                      .read(userInformationProvider.notifier)
                      .updateUsername(value);
                  updateUsername(value);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(userInformationProvider.notifier)
                      .updateUsername(controller.text);
                  updateUsername(controller.text);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
