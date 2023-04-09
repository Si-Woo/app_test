import 'package:emerald/api/userInfo.dart';

class Post {
  final String? title;
  final String? content;
  final UserInfo? id;
  final UserInfo? nick;
  final DateTime? created;

  Post({
    this.title,
    this.content,
    this.id,
    this.nick,
    this.created,
  });

  Post.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        content = json["content"],
        id = json["user_id"],
        nick = json["nick"],
        created = json["created_at"].toDate();
}
