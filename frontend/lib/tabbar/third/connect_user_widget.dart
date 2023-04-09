import 'package:emerald/tabbar/first/post_detail.dart';
import 'package:emerald/tabbar/third/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class User extends StatelessWidget {
  final String id, nick, imageUrl;

  const User({
    super.key,
    required this.id,
    required this.nick,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetail(
              id: id,
              nick: nick,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        // color: Colors.yellow,
        height: 60,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(
                  imageUrl,
                  scale: 1.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
            ),
            Text(
              nick,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
