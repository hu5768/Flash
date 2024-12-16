class CenterDetailModel {
  String? gymName;
  String? mapImageUrl;
  String? calendarImageUrl;
  List<String>? difficulties;
  List<Sectors>? sectors;

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
    if (json['sectors'] != null) {
      sectors = <Sectors>[];
      json['sectors'].forEach((v) {
        sectors!.add(Sectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gymName'] = gymName;
    data['mapImageUrl'] = mapImageUrl;
    data['calendarImageUrl'] = calendarImageUrl;
    data['difficulties'] = difficulties;
    if (sectors != null) {
      data['sectors'] = sectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sectors {
  int? id;
  String? name;
  String? selectedImageUrl;

  Sectors({this.id, this.name, this.selectedImageUrl});

  Sectors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    selectedImageUrl = json['selectedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['selectedImageUrl'] = selectedImageUrl;
    return data;
  }
}
