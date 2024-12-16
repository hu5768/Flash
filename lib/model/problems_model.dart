class ProblemModel {
  String? id;
  String? sector;
  String? difficulty;
  String? settingDate;
  String? removalDate;
  bool? hasSolution;
  String? imageUrl;
  String? holdColorCode;
  bool? isHoney;
  int? solutionCount;

  ProblemModel({
    this.id,
    this.sector,
    this.difficulty,
    this.settingDate,
    this.removalDate,
    this.hasSolution,
    this.imageUrl,
    this.holdColorCode,
    this.isHoney,
    this.solutionCount,
  });

  ProblemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    difficulty = json['difficulty'];
    settingDate = json['settingDate'];
    removalDate = json['removalDate'];
    hasSolution = json['hasSolution'];
    imageUrl = json['imageUrl'];
    holdColorCode = json['holdColorCode'];
    isHoney = json['isHoney'];
    solutionCount = json['solutionCount'];
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
    data['holdColorCode'] = holdColorCode;
    data['isHoney'] = isHoney;
    data['solutionCount'] = solutionCount;
    return data;
  }
}
