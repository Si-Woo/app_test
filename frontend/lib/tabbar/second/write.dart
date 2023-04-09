import 'package:emerald/component/checkButton.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../api/dio_service.dart';
import '../../api/userInfo.dart';

class Write extends StatefulWidget {
  final String id, nick, category;
  const Write({
    super.key,
    required this.id,
    required this.nick,
    required this.category,
  });

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "글쓰기",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 40, 220, 190),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _titleInput(),
              _contentInput(),
              _writeCheckButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목',
                contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "제목을 입력해주세요";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _content,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
                contentPadding: EdgeInsets.fromLTRB(0, 300, 0, 0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "내용을 입력해주세요";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _writeCheckButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        child: Text("확인"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var message = "이미 작성된 내용입니다.";
            var res = await server.writeReq(
              widget.id,
              _title.text,
              _content.text,
              widget.category,
            );
            if (res == "success") {
              checkButton(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.tealAccent,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
