class UserInfo {
  final String id, nick, imageUrl;
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json["user_id"],
        imageUrl = json["imageUrl"],
        nick = json["nick"];
}
