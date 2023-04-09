class Message {
  String name;
  String message;
  int time;

  Message({required this.name, required this.message, required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json['name'],
      message: json['message'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['message'] = message;
    data['time'] = time;
    return data;
  }
}
