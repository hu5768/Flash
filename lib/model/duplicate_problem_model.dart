class DuplicateProblemModel {
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

  DuplicateProblemModel({
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

  DuplicateProblemModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sector'] = this.sector;
    data['difficulty'] = this.difficulty;
    data['settingDate'] = this.settingDate;
    data['removalDate'] = this.removalDate;
    data['hasSolution'] = this.hasSolution;
    data['imageUrl'] = this.imageUrl;
    data['holdColorCode'] = this.holdColorCode;
    data['isHoney'] = this.isHoney;
    data['solutionCount'] = this.solutionCount;
    return data;
  }
}
