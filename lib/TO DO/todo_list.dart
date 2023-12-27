import 'package:firebase_display/TO%20DO/Model/todo_model.dart';
import 'package:firebase_display/TO%20DO/Service/todo_database_service.dart';
import 'package:firebase_display/TO%20DO/loader.dart';
import 'package:firebase_display/TO%20DO/mytodo_dialog.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController todoTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: SafeArea(
            child: StreamBuilder<List<TodoModel>>(
                stream: ToDoDatabaseService().listTodo(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Loader();
                  }
                  List<TodoModel>? todo = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My To Do",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: todo!.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(todo[index].uid),
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  color: Colors.red,
                                  child: const Icon(Icons.delete),
                                ),
                                onDismissed: (direction) async {
                                  await ToDoDatabaseService()
                                      .deleteTodo(todo[index].uid);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: ListTile(
                                      onTap: () {
                                        bool newCompleteTask =
                                            !todo[index].isCompleted;
                                        ToDoDatabaseService().updateTask(
                                            todo[index].uid, newCompleteTask);
                                      },
                                      leading: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                          color: Colors.purple,
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: todo[index].isCompleted
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                      ),
                                      title: Text(
                                        todo[index].title,
                                        style: const TextStyle(
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) =>
                  ToDoDialog(todoTitleController: todoTitleController)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
