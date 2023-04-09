import 'package:flutter/material.dart';

class GetCategoryDetail extends StatelessWidget {
  final String id, title, content, category, nick;

  const GetCategoryDetail({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.nick,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "게시판",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: const Color.fromARGB(255, 40, 220, 190),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              width: size.width,
              // color: Colors.grey,
              child: Text(
                "작성자: $nick",
                style: const TextStyle(fontSize: 17),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              // color: Colors.pink,
              width: size.width,
              height: 350,
              child: Text(
                content,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
