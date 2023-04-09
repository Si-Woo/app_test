import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../first/post_detail.dart';

class GetFreeboard extends StatelessWidget {
  final String id, title, content, category, nick, created;
  const GetFreeboard({
    super.key,
    required this.id,
    required this.nick,
    required this.title,
    required this.content,
    required this.category,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    String year = created.split("T")[0];
    String time = created.split(".")[0];
    time = time.split("T")[1];
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
      child: SizedBox(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "$nick | $year $time",
              style: TextStyle(fontSize: 13), // 목록 글자 크기
            ),
          ],
        ),
      ),
    );
  }
}
