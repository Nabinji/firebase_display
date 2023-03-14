import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageSliderFirebaseStorage(),
    );
  }
}

class ImageSliderFirebaseStorage extends StatefulWidget {
  const ImageSliderFirebaseStorage({Key? key}) : super(key: key);

  @override
  State<ImageSliderFirebaseStorage> createState() =>
      _ImageSliderFirebaseStorageState();
}

class _ImageSliderFirebaseStorageState
    extends State<ImageSliderFirebaseStorage> {
  late String imageUrl;
  late String imageurll;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // Set the initial value of imageUrl to an empty string
    imageUrl = '';
    imageurll = '';
    // Retrieve the image from Firebase Storage
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    // Get the reference to the image file in Firebase Storage
    final ref = storage.ref().child('banner.jpg');
    final reff = storage.ref().child('java.jpg');
    // Get the download URL for the image
    final url = await ref.getDownloadURL();
    final urll = await reff.getDownloadURL();
    // Set the imageUrl to the download URL
    setState(() {
      imageUrl = url;
      imageurll = urll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 300,
            child: Card(
              child: Image(
                image: NetworkImage(imageurll),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
