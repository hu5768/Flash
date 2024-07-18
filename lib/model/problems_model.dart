class ProblemModel {
  String? id;
  String? sector;
  String? difficulty;
  String? settingDate;
  String? removalDate;
  bool? hasSolution;
  String? imageUrl;

  ProblemModel({
    this.id,
    this.sector,
    this.difficulty,
    this.settingDate,
    this.removalDate,
    this.hasSolution,
    this.imageUrl,
  });

  ProblemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    difficulty = json['difficulty'];
    settingDate = json['settingDate'];
    removalDate = json['removalDate'];
    hasSolution = json['hasSolution'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sector'] = sector;
    data['difficulty'] = difficulty;
    data['settingDate'] = settingDate;
    data['removalDate'] = removalDate;
    data['hasSolution'] = hasSolution;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
