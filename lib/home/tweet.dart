class Tweet {
  int id;
  String profile;
  int createdDate;
  String author;
  String message;

  Tweet(this.id, this.profile, this.createdDate, this.author, this.message);

  static Tweet fromJson(Map<String, dynamic> json) {
    return Tweet(
      json['id'],
      json['profile'],
      json['created_date'],
      json['author'],
      json['message'],
    );
  }
}
