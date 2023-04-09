class GetPostData {
  final String id, title, content, category, nick, created;
  GetPostData.fromJson(Map<String, dynamic> json)
      : id = json["user_id"],
        nick = json["nick"],
        title = json["title"],
        content = json["content"],
        category = json["category"],
        created = json["created_at"];
}
