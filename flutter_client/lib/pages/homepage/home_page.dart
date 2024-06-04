import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> users = const ["Robert", "Alain", "Sarah", "Pascal"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("List of connected users"),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(users[index]),
                      onTap: () {
                        Navigator.of(context).pushNamed("/chat");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
