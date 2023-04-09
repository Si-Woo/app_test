class Room {
  final int id;
  final String name;

  Room.fromJson(Map<String, dynamic> json)
      : id = json["room_id"],
        name = json["name"];
}
