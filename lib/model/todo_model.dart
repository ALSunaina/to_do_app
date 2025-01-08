class GetTodosModel {
  final String title;
  final bool completed;
  final int userId;
  final int id;

  GetTodosModel({required this.title, required this.completed, required this.userId, required this.id});

  factory GetTodosModel.fromJson(Map<String, dynamic> json) {
    return GetTodosModel(
      title: json['title'],
      completed: json['completed'],
      userId: json['userId'],
      id: json['id'],
    );
  }


}