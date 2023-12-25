import 'package:firebase_display/TO%20DO/services/database_services.dart';
import 'package:flutter/material.dart';

class TodoDialog extends StatelessWidget {
  final TextEditingController todoTitleController;

  const TodoDialog({super.key, required this.todoTitleController});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          const Text(
            "Add Todo",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      children: [
        TextFormField(
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          controller: todoTitleController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "eg. My Meeting",
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: width,
          height: 50,
          child: ElevatedButton(
            child: const Text("Add"),
            onPressed: () async {
              if (todoTitleController.text.isNotEmpty) {
                await DatabaseService()
                    .createNewTodo(todoTitleController.text.trim());
              }
              Navigator.pop(context);
              todoTitleController.clear();
            },
          ),
        )
      ],
    );
  }
}
