class NewsModel {
  String photo;
  String body;
  String newID;

  NewsModel({
    this.photo,
    this.body,
    this.newID,
  });

  factory NewsModel.fromJson(Map json) {
    return NewsModel(
      body: json['body'],
      photo: json['photo'],
      newID: json['newID'],
    );
  }
}
