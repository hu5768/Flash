class SectorModel {
  int? id;
  SectorName? sectorName;
  String? settingDate;
  RemovalInfo? removalInfo;
  int? gymId;

  SectorModel({
    this.id,
    this.sectorName,
    this.settingDate,
    this.removalInfo,
    this.gymId,
  });

  SectorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectorName = json['sectorName'] != null
        ? SectorName.fromJson(json['sectorName'])
        : null;
    settingDate = json['settingDate'];
    removalInfo = json['removalInfo'] != null
        ? RemovalInfo.fromJson(json['removalInfo'])
        : null;
    gymId = json['gymId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sectorName != null) {
      data['sectorName'] = sectorName!.toJson();
    }
    data['settingDate'] = settingDate;
    if (removalInfo != null) {
      data['removalInfo'] = removalInfo!.toJson();
    }
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

class RemovalInfo {
  String? removalDate;
  bool? isFakeRemovalDate;
  bool? isExpired;

  RemovalInfo({this.removalDate, this.isFakeRemovalDate, this.isExpired});

  RemovalInfo.fromJson(Map<String, dynamic> json) {
    removalDate = json['removalDate'];
    isFakeRemovalDate = json['isFakeRemovalDate'];
    isExpired = json['isExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['removalDate'] = removalDate;
    data['isFakeRemovalDate'] = isFakeRemovalDate;
    data['isExpired'] = isExpired;
    return data;
  }
}
