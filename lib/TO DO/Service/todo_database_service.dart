import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_display/TO%20DO/Model/todo_model.dart';

class ToDoDatabaseService {
  CollectionReference toDoCollection =
      FirebaseFirestore.instance.collection("TodoList");

  // For ToDo order based on their addin times
  Stream<List<TodoModel>> listTodo() {
    return toDoCollection
        .orderBy("Timestamp", descending: true)
        .snapshots()
        .map(todoFromFirestore);
  } // After that the most recemt added item's are top on the list

  Future createNewTodo(String titie) async {
    return await toDoCollection.add({
      "title": titie,
      "isCompleted": false,
      "Timestamp": FieldValue.serverTimestamp(),
    });
  }

  // For Updating the Todo
  Future updateTask(uid, bool newCompleteTask) async {
    await toDoCollection.doc(uid).update({"isCompleted": newCompleteTask});
  }

  // For Delete the Todo
  Future deleteTodo(uid) async {
    await toDoCollection.doc(uid).delete();
  }

  List<TodoModel> todoFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      Map<String, dynamic>? data = e.data() as Map<String, dynamic>?;

      return TodoModel(
          isCompleted: data?['isCompleted'] ?? true,
          title: data?['title'] ?? "",
          uid: e.id);
    }).toList();
  }
}
