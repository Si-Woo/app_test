import 'package:emerald/tabbar/first/post_detail.dart';
import 'package:flutter/material.dart';

class GetCategory extends StatelessWidget {
  final String id, title, content, category, nick;

  const GetCategory({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.nick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetail(
              id: id,
              nick: nick,
              title: title,
              content: content,
              category: category,
            ),
          ),
        );
      },
      child: Text(
        title,
        style: const TextStyle(fontSize: 16), // 목록 글자 크기
      ),
    );
  }
}
