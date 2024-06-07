import 'package:flutter/material.dart';

import '../../Widgets/default_app_bar.dart';

class ErrorConnectionView extends StatelessWidget {
  const ErrorConnectionView({
    super.key,
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Error"),
      body: Text('Error: $error'),
    );
  }
}
