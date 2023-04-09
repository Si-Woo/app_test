import 'package:flutter/material.dart';

Future checkButton(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:(BuildContext ctx) {
      return AlertDialog(
        content: Text("회원가입 완료되었습니다."),
        actions: [
          Center(
            child: ElevatedButton(
              child: Text("확인"),
              onPressed: () {
                CircularProgressIndicator();
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )
              ),
              ),
          )
        ],
      );
    },);
}