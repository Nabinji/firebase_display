import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'firebase_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirestoreImageDisplay(),
  ));
}
