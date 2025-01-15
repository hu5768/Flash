class MySolutionModel {
  int? gymId;
  String? gymName;
  List<Difficulties>? difficulties;
  String? solvedDate;
  String? thumbnailImageUrl;

  MySolutionModel({
    this.gymId,
    this.gymName,
    this.difficulties,
    this.solvedDate,
    this.thumbnailImageUrl,
  });

  MySolutionModel.fromJson(Map<String, dynamic> json) {
    gymId = json['gymId'];
    gymName = json['gymName'];
    if (json['difficulties'] != null) {
      difficulties = <Difficulties>[];
      json['difficulties'].forEach((v) {
        difficulties!.add(new Difficulties.fromJson(v));
      });
    }
    solvedDate = json['solvedDate'];
    thumbnailImageUrl = json['thumbnailImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gymId'] = this.gymId;
    data['gymName'] = this.gymName;
    if (this.difficulties != null) {
      data['difficulties'] = this.difficulties!.map((v) => v.toJson()).toList();
    }
    data['solvedDate'] = this.solvedDate;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    return data;
  }
}

class Difficulties {
  String? difficultyName;
  int? count;

  Difficulties({this.difficultyName, this.count});

  Difficulties.fromJson(Map<String, dynamic> json) {
    difficultyName = json['difficultyName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['difficultyName'] = this.difficultyName;
    data['count'] = this.count;
    return data;
  }
}
