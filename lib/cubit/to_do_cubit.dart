import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:todoapp/cubit/to_do_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState()) {
    initializeTodos();
  }

  //add function
  void addTodo(String title) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
    );
    final updatedTodos = [...state.todos, newTodo];
    emit(TodoState(todos: updatedTodos));
    saveTodos(updatedTodos);
  }

  //edit function
  void editTodo(String id, String newTitle) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(title: newTitle);
      }
      return todo;
    }).toList();

    emit(TodoState(todos: updatedTodos));
    saveTodos(updatedTodos);
  }

  void toggleTodoStatus(String id) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted, title: todo.title);
      }
      return todo;
    }).toList();

    emit(TodoState(todos: updatedTodos));
    saveTodos(updatedTodos);
  }

  //delete function
  void deleteTodo(String id) {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    emit(TodoState(todos: updatedTodos));
    saveTodos(updatedTodos);
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => todo.toJson()).toList();
    await prefs.setString('todos', jsonEncode(todosJson));
  }

  Future<void> initializeTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos');

    if (todosJson != null) {
      final List<dynamic> decodedJson = jsonDecode(todosJson) as List<dynamic>;
      final List<Todo> loadedTodos = decodedJson
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
          .toList();
      emit(TodoState(todos: loadedTodos));
    }
  }
}
