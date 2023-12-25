import 'package:firebase_display/TO%20DO/loading.dart';
import 'package:firebase_display/TO%20DO/model/todo.dart';
import 'package:firebase_display/TO%20DO/services/database_services.dart';
import 'package:firebase_display/TO%20DO/services/show_dialog.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController todoTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder<List<Todo>>(
              stream: DatabaseService().listTodos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loading(); //If data is not available yet, it returns a Loading
                }
                List<Todo>? todos = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My To Do",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: todos!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(todos[index]
                                .uid), // Use a unique identifier for the key
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: const Icon(Icons.delete),
                            ),
                            onDismissed: (direction) async {
                              // Remove the dismissed item from the todos list
                              await DatabaseService()
                                  .removeTodo(todos[index].uid);
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ListTile(
                                  splashColor: Colors.amber,
                                  onTap: () {
                                    bool newCompletionStatus =
                                        !todos[index].isComplet;
                                    DatabaseService().completTask(
                                      todos[index].uid,
                                      newCompletionStatus,
                                    );
                                  },
                                  leading: Container(
                                    padding: const EdgeInsets.all(2),
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: todos[index].isComplet
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                  ),
                                  title: Text(
                                    todos[index].title,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                TodoDialog(todoTitleController: todoTitleController),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
