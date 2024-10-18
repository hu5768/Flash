class ProblemDetailModel {
  String? id;
  String? sector;
  String? difficulty;
  String? settingDate;
  String? removalDate;
  bool? isFakeRemovalDate;
  bool? hasSolution;
  String? imageUrl;
  String? gymName;
  String? imageSource;
  bool? isHoney;

  ProblemDetailModel({
    this.id,
    this.sector,
    this.difficulty,
    this.settingDate,
    this.removalDate,
    this.isFakeRemovalDate,
    this.hasSolution,
    this.imageUrl,
    this.gymName,
    this.imageSource,
    this.isHoney,
  });

  ProblemDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    difficulty = json['difficulty'];
    settingDate = json['settingDate'];
    removalDate = json['removalDate'];
    isFakeRemovalDate = json['isFakeRemovalDate'];
    hasSolution = json['hasSolution'];
    imageUrl = json['imageUrl'];
    gymName = json['gymName'];
    imageSource = json['imageSource'];
    isHoney = json['isHoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sector'] = this.sector;
    data['difficulty'] = this.difficulty;
    data['settingDate'] = this.settingDate;
    data['removalDate'] = this.removalDate;
    data['isFakeRemovalDate'] = this.isFakeRemovalDate;
    data['hasSolution'] = this.hasSolution;
    data['imageUrl'] = this.imageUrl;
    data['gymName'] = this.gymName;
    data['imageSource'] = this.imageSource;
    data['isHoney'] = this.isHoney;
    return data;
  }
}
