class FakeUsers {
  final int id;
  final String title, body;
  //final bool fav;

  FakeUsers({
    required this.id,
    required this.title,
    required this.body,
  });
  factory FakeUsers.fromJson(Map<String, dynamic> json) => FakeUsers(
        id: json["id"],
        title: json["name"],
        body: json["body"],
      );
}
