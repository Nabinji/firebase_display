import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDropdownMenuItem extends StatefulWidget {
  const FirebaseDropdownMenuItem({super.key});

  @override
  _CommonStreamState createState() => _CommonStreamState();
}

class _CommonStreamState extends State<FirebaseDropdownMenuItem> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(" Firebase DropdownMenuItems"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Programming_Language")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occured ${snapshot.error}"),
            );
          }
          List<DropdownMenuItem> programItems = [];
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final selectProgram = snapshot.data?.docs.reversed.toList();
            if (selectProgram != null) {
              for (var program in selectProgram) {
                programItems.add(
                  DropdownMenuItem(
                    value: program.id,
                    child: Text(
                      program['name'],
                    ),
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  hint: const Text(
                    "Select the Items",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: selectedValue,
                  items: programItems,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
