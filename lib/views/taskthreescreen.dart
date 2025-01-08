import 'package:flutter/material.dart';
import 'package:todoapp/core/network/api_service.dart';
import 'package:todoapp/model/get_posts_model.dart';
import 'package:todoapp/model/todo_model.dart';

class TaskThreeScreen extends StatefulWidget {
  const TaskThreeScreen({super.key});

  @override
  State<TaskThreeScreen> createState() => _TaskThreeScreenState();
}

class _TaskThreeScreenState extends State<TaskThreeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<String> tabName = ["Tab 1", "Tab 2"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabName.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String> getData() {
    return Future.delayed(const Duration(seconds: 2), () {
      return "I am data";
    });
  }

  Future<List<Object>> fetchTabData(int index) {
    if (index == 0) {
      return ApiService().getPosts();
    } else {
      return ApiService().getTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Three"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabName
              .map((title) => Tab(
                    text: title,
                  ))
              .toList(),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchTabData(_currentIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            if (_currentIndex == 0) {
              return ListView(
                children: snapshot.data!
                    .map((e) => ListTile(
                          title: Text("Title: ${(e as GetPostsModel).title}"),
                          subtitle: Text("Body: ${e.body}"),
                        ))
                    .toList(),
              );
            } else {
              return ListView(
                children: snapshot.data!
                    .map((e) => ListTile(
                          title: Text("Title: ${(e as GetTodosModel).title}"),
                          subtitle: Text("Completed: ${(e).completed}"),
                        ))
                    .toList(),
              );
            }
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }
}

      // body: FutureBuilder<List<GetPostsModel>>(
      //   future: fetchTabData(_currentIndex),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView(children: [
      //         ...snapshot.data!.map((e) => ListTile(
      //               title: Text("title: ${e.title}"),
      //               subtitle: Text("body: ${e.body}"),
      //             ))
      //       ]);
      //     } else if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   },
      // )


      // body: FutureBuilder(
      //     builder: (ctx, snapshot) {
      //       // Checking if future is resolved or not
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         // If we got an error
      //         if (snapshot.hasError) {
      //           return Center(
      //             child: Text(
      //               '${snapshot.error} occurred',
      //               style: const TextStyle(fontSize: 18),
      //             ),
      //           );

      //           // if we got our data
      //         } else if (snapshot.hasData) {
      //           // Extracting data from snapshot object
      //           final data = snapshot.data as String;
      //           return Center(
      //             child: Text(
      //               data,
      //               style: const TextStyle(fontSize: 18),
      //             ),
      //           );
      //         }
      //       }

      //       // Displaying LoadingSpinner to indicate waiting state
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     },

      //     // Future that needs to be resolved
      //     // inorder to display something on the Canvas
      //     future: getData(),
      //   ),
