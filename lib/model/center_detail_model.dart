class CenterDetailModel {
  String? gymName;
  String? mapImageUrl;
  String? calendarImageUrl;
  List<String>? difficulties;
  List<String>? sectors;

  CenterDetailModel({
    this.gymName,
    this.mapImageUrl,
    this.calendarImageUrl,
    this.difficulties,
    this.sectors,
  });

  CenterDetailModel.fromJson(Map<String, dynamic> json) {
    gymName = json['gymName'];
    mapImageUrl = json['mapImageUrl'];
    calendarImageUrl = json['calendarImageUrl'];
    difficulties = json['difficulties'].cast<String>();
    sectors = json['sectors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gymName'] = this.gymName;
    data['mapImageUrl'] = this.mapImageUrl;
    data['calendarImageUrl'] = this.calendarImageUrl;
    data['difficulties'] = this.difficulties;
    data['sectors'] = this.sectors;
    return data;
  }
}
