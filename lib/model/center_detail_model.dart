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
        sectors!.add(new Sectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gymName'] = this.gymName;
    data['mapImageUrl'] = this.mapImageUrl;
    data['calendarImageUrl'] = this.calendarImageUrl;
    data['difficulties'] = this.difficulties;
    if (this.sectors != null) {
      data['sectors'] = this.sectors!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['selectedImageUrl'] = this.selectedImageUrl;
    return data;
  }
}
