import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/to_do_cubit.dart';
import 'package:todoapp/cubit/to_do_state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => showAddTodoDialogBox(context),
                  child: const Text("Add Todo")),
              Expanded(
                child: BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                todoCubit.toggleTodoStatus(todo.id);
                              },
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showEditTodoDialogBox(context, todo);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    todoCubit.deleteTodo(todo.id);
                                  },
                                ),
                              ],
                            ),
                            tileColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  //modal to add todo

// make common alert box for add and edit
  void showAddTodoDialogBox(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add To-Do"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter title"),
          ),
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<TodoCubit>().addTodo(controller.text);
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

void showEditTodoDialogBox(BuildContext context, Todo todo) {
  final TextEditingController controller =
      TextEditingController(text: todo.title);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Edit To-Do"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new task title"),
        ),
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<TodoCubit>().editTodo(todo.id, controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
