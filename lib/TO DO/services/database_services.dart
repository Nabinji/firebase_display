import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_display/TO%20DO/model/todo.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("Todos");

// Todos will be ordered based on their adding time

  Stream<List<Todo>> listTodos() {
    return todosCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(todoFromFirestore);
  } // After that most recent added item's are top on the list

  Future createNewTodo(String title) async {
    return await todosCollection.add({
      "title": title,
      "isComplet": false,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

// For Updating the ToDo
  Future completTask(uid, bool newCompletionStatus) async {
    await todosCollection.doc(uid).update({"isComplet": newCompletionStatus});
  }

// For Delete the todo items
  Future removeTodo(uid) async {
    await todosCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      Map<String, dynamic>? data = e.data()
          as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>

      return Todo(
        isComplet: data?['isComplet'] ?? true,
        title: data?['title'] ?? "",
        uid: e.id,
      );
    }).toList();
  }
}
