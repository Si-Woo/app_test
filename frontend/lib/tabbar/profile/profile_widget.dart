import 'package:emerald/tabbar/profile/profile.dart';
import 'package:emerald/tabbar/second/write.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String id, nick, imageUrl;
  const ProfileWidget({
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
              builder: (context) => Profile(
                id: id,
                nick: nick,
                imageUrl: imageUrl,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 8), // padding이나 margin이나 똑같...
        // padding: EdgeInsets.only(top: 8),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl) == null
              ? NetworkImage("https://picsum.photos/200")
              : NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
