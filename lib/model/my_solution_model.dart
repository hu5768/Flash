class MySolutionModel {
  int? solutionId;
  String? gymName;
  String? sectorName;
  String? difficultyName;
  String? problemImageUrl;
  String? uploadedAt;

  MySolutionModel({
    this.solutionId,
    this.gymName,
    this.sectorName,
    this.difficultyName,
    this.problemImageUrl,
    this.uploadedAt,
  });

  MySolutionModel.fromJson(Map<String, dynamic> json) {
    solutionId = json['solutionId'];
    gymName = json['gymName'];
    sectorName = json['sectorName'];
    difficultyName = json['difficultyName'];
    problemImageUrl = json['problemImageUrl'];
    uploadedAt = json['uploadedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['solutionId'] = this.solutionId;
    data['gymName'] = this.gymName;
    data['sectorName'] = this.sectorName;
    data['difficultyName'] = this.difficultyName;
    data['problemImageUrl'] = this.problemImageUrl;
    data['uploadedAt'] = this.uploadedAt;
    return data;
  }
}
