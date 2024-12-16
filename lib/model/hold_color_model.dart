class HoldColorModel {
  int? id;
  String? colorName;
  String? colorCode;

  HoldColorModel({this.id, this.colorName, this.colorCode});

  HoldColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    return data;
  }
}
