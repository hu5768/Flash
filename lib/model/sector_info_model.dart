class SectorInfoModel {
  int? id;
  SectorName? sectorName;
  String? selectedImageUrl;
  int? gymId;

  SectorInfoModel({
    this.id,
    this.sectorName,
    this.selectedImageUrl,
    this.gymId,
  });

  SectorInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectorName = json['sectorName'] != null
        ? SectorName.fromJson(json['sectorName'])
        : null;
    selectedImageUrl = json['selectedImageUrl'];
    gymId = json['gymId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sectorName != null) {
      data['sectorName'] = sectorName!.toJson();
    }
    data['selectedImageUrl'] = selectedImageUrl;
    data['gymId'] = gymId;
    return data;
  }
}

class SectorName {
  String? name;
  String? adminName;

  SectorName({this.name, this.adminName});

  SectorName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    adminName = json['adminName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['adminName'] = adminName;
    return data;
  }
}
