// import 'package:equatable/equatable.dart';
// // Basic state class
// class Todo {
//   final String id;
//   final String title;
//   final bool isCompleted;

//   Todo({
//     required this.id,
//     required this.title,
//     this.isCompleted = false,
//   });

//   Todo copyWith({bool? isCompleted, required String title}) {
//     return Todo(
//       id: id,
//       title: title,
//       isCompleted: isCompleted ?? this.isCompleted,
//     );
//   }

//   static fromJson(json) {}

//   toJson() {}
// }

// class TodoState extends Equatable {
//   final List<Todo> todos;

//   const TodoState({this.todos = const []});

//   @override
//   List<Object> get props => [todos];
// }

import 'package:equatable/equatable.dart';

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Converting a Todo object into a dynamic list
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Create a Todo from a dynamic list
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  // Copy a Todo
  Todo copyWith({String? id, String? title, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({this.todos = const []});

  @override
  List<Object> get props => [todos];
}
