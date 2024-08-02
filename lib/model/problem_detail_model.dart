class ProblemDetailModel {
  String? id;
  String? gymName;
  String? sector;
  String? difficulty;
  String? settingDate;
  String? removalDate;
  bool? isFakeRemovalDate;
  bool? hasSolution;
  String? imageUrl;

  ProblemDetailModel({
    this.id,
    this.gymName,
    this.sector,
    this.difficulty,
    this.settingDate,
    this.removalDate,
    this.isFakeRemovalDate,
    this.hasSolution,
    this.imageUrl,
  });

  ProblemDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gymName = json['gymName'];
    sector = json['sector'];
    difficulty = json['difficulty'];
    settingDate = json['settingDate'];
    removalDate = json['removalDate'];
    isFakeRemovalDate = json['isFakeRemovalDate'];
    hasSolution = json['hasSolution'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gymName'] = gymName;
    data['sector'] = sector;
    data['difficulty'] = difficulty;
    data['settingDate'] = settingDate;
    data['removalDate'] = removalDate;
    data['isFakeRemovalDate'] = isFakeRemovalDate;
    data['hasSolution'] = hasSolution;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
