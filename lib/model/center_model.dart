class Centers {
  final int id;
  final String gymName, thumbnailUrl;
  //final bool fav;

  Centers({
    required this.id,
    required this.gymName,
    //required this.fav,
    required this.thumbnailUrl,
  });
  factory Centers.fromJson(Map<String, dynamic> json) => Centers(
        id: json["id"],
        gymName: json["gymName"],
        thumbnailUrl: json["thumbnailUrl"],
      );
}
