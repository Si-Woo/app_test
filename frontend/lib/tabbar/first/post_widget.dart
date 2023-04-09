import 'package:emerald/tabbar/first/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Post extends StatelessWidget {
  final String id, title, content, category, nick;

  const Post({
    super.key,
    required this.id,
    required this.nick,
    required this.title,
    required this.content,
    required this.category,
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
        "[$category] $title",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
