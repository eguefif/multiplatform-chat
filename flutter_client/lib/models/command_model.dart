class CommandModel {
  final String command;
  final String content;

  const CommandModel({required this.command, required this.content});

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(command: json['command'], content: json['content']);
  }
}
