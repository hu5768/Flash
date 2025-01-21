class AchievementModel {
  int? id;
  int? solveCount;
  String? difficultyName;
  String? gymName;

  AchievementModel({
    this.id,
    this.solveCount,
    this.difficultyName,
    this.gymName,
  });

  AchievementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    solveCount = json['solveCount'];
    difficultyName = json['difficultyName'];
    gymName = json['gymName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['solveCount'] = this.solveCount;
    data['difficultyName'] = this.difficultyName;
    data['gymName'] = this.gymName;
    return data;
  }
}
