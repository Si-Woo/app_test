import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../api/websocket.dart';

final channel = IOWebSocketChannel.connect('ws://172.30.1.50:8080/ws/1/siwoo');

class FourthPage extends StatefulWidget {
  final String id;
  const FourthPage({super.key, required this.id});
  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  // final _channel = IOWebSocketChannel.connect('ws://172.30.1.50:8080/ws');
  late TextEditingController _textEditingController;
  late IOWebSocketChannel _webSocketChannel;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _webSocketChannel = IOWebSocketChannel.connect('ws://172.30.1.50:8080/ws');
    _webSocketChannel.stream.listen((message) {
      print('Message received: $message');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _webSocketChannel.sink.close();
    super.dispose();
  }

  void _sendMessage() async {
    final url = Uri.parse('http://172.30.1.50:8080/message');
    final message = {
      'sender': 'test',
      'recipient': 'siwoo',
      'content': _textEditingController.text,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message));
    print('Message sent with status code: ${response.statusCode}');
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat App'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _webSocketChannel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = jsonDecode(snapshot.data);
                    final sender = data['sender'] ?? 'unknown';
                    final content = data['content'] ?? '';
                    final time = data['time'] ?? 0;
                    final dateTime = DateTime.fromMillisecondsSinceEpoch(time);
                    final timeString =
                        '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
                    return ListTile(
                      title: Text('$sender ($timeString)'),
                      subtitle: Text(content),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: 'Enter message...'),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
