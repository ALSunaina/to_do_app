class GetPostsModel {
  final String title;
  final String body;
  final int userId;
  final int id;

  GetPostsModel({required this.title, required this.body, required this.userId, required this.id});

  factory GetPostsModel.fromJson(Map<String, dynamic> json) {
    return GetPostsModel(
      title: json['title'] as String,
      body: json['body'],
      userId: json['userId'],
      id: json['id'],
    );
  }

}