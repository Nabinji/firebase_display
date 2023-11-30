import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({super.key});

  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation> {
  // text field controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Create your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(labelText: 'S.N', hintText: 'eg.1'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: const InputDecoration(
                      labelText: 'Number', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        final String name = _nameController.text;
                        final int? sn = int.tryParse(_snController.text);
                        final int? number =
                            int.tryParse(_numberController.text);
                        if (number != null) {
                          await _items
                              .add({"name": name, "number": number, "sn": sn});
                          _nameController.text = '';
                          _snController.text = '';
                          _numberController.text = '';

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Create")),
                )
              ],
            ),
          );
        });
  }

  // for Update operation
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _snController.text = documentSnapshot['sn'].toString();
      _numberController.text = documentSnapshot['number'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(labelText: 'S.N', hintText: 'eg.1'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: const InputDecoration(
                      labelText: 'Number', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final int? sn = int.tryParse(_snController.text);
                      final int? number = int.tryParse(_numberController.text);
                      if (number != null) {
                        await _items
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "number": number, "sn": sn});
                        _nameController.text = '';
                        _snController.text = '';
                        _numberController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }

  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted a itmes")));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 95, 226, 77),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('CRUD Operaion'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['name'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
                  return Card(
                    color: const Color.fromARGB(255, 88, 136, 190),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: const Color.fromARGB(255, 26, 226, 76),
                        child: Text(
                          documentSnapshot['sn'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      title: Text(
                        documentSnapshot['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(documentSnapshot['number'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
