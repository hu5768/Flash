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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['colorName'] = this.colorName;
    data['colorCode'] = this.colorCode;
    return data;
  }
}
