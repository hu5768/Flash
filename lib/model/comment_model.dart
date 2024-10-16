class CommentModel {
  int? id;
  String? content;
  String? commenterId;
  String? nickName;
  String? profileImageUrl;
  bool? isMine;

  CommentModel({
    this.id,
    this.content,
    this.commenterId,
    this.nickName,
    this.profileImageUrl,
    this.isMine,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    commenterId = json['commenterId'];
    nickName = json['nickName'];
    profileImageUrl = json['profileImageUrl'];
    isMine = json['isMine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['commenterId'] = this.commenterId;
    data['nickName'] = this.nickName;
    data['profileImageUrl'] = this.profileImageUrl;
    data['isMine'] = this.isMine;
    return data;
  }
}
