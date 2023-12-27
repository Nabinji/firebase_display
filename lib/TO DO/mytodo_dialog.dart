import 'package:firebase_display/TO%20DO/Service/todo_database_service.dart';
import 'package:flutter/material.dart';

class ToDoDialog extends StatelessWidget {
  const ToDoDialog({super.key, required this.todoTitleController});
  final TextEditingController todoTitleController;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Text(
            "Add Todo",
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.white))
        ],
      ),
      children: [
        TextFormField(
          controller: todoTitleController,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          autofocus: true,
          decoration: const InputDecoration(
              hintText: "eg.My Meeting",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              onPressed: () async {
                if (todoTitleController.text.isNotEmpty) {
                  await ToDoDatabaseService()
                      .createNewTodo(todoTitleController.text.trim());
                }
                //For Dismiss the dialog
                Navigator.pop(context);
                // For clear the textfield
                todoTitleController.clear();
              },
              child: const Text("Add")),
        )
      ],
    );
  }
}
