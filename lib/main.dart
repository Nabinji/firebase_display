import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_display/RealTimeDatabase%20CRUD/real_tim_crud.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  // Connets your flutter project with firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RealTimeCRUDEdatabase(),
    );
  }
}
