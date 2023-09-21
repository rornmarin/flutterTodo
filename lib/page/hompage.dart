import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/auth_controler.dart';
import 'package:todo_app/util/custom_card_search.dart';
import 'package:todo_app/util/dialog_box.dart';

import 'package:todo_app/util/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authCon = Get.put(AuthController());
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: authCon.title,
            onSave: () {
              debugPrint('------is ${authCon.title.text}');
              Map<String, dynamic> itemData = {
                'title': authCon.title.text,
                "taskCompleted": false,
              };
              var collection = FirebaseFirestore.instance.collection('items');
              collection
                  .add(itemData)
                  .then((_) => {Navigator.pop(context)})
                  .catchError(
                    (error) => {
                      debugPrint('---------->>Add failed: $error'),
                    },
                  );
            },
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  bool boolean1 = false;
  void toggleBoolean1() {
    setState(() {
      boolean1 = !boolean1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCon = Get.put(AuthController);
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    String name = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text('Todo List'),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const SizedBox(height: 20),
          CustomcardSearch(
            onChanged: (value) {
              name = value;
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documnents =
                        snapshot.data!.docs;
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            children: documnents
                                .map(
                                  (doc) => Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: ToDoTile(
                                      documentSnapshot: doc,
                                      taskName: doc['title'],
                                      taskCompleted: doc['taskCompleted'],
                                      onTap: toggleBoolean1,
                                      onChanged: (p0) async {
                                        setState(() {
                                          boolean1 = !boolean1;
                                        });
                                        final usercolloction = FirebaseFirestore
                                            .instance
                                            .collection("items");
                                        final docRef =
                                            usercolloction.doc(doc.id);
                                        try {
                                          await docRef.update({
                                            "taskCompleted": boolean1,
                                          });
                                          const CircularProgressIndicator();
                                        } catch (e) {
                                          debugPrint("--------$e");
                                        }
                                      },
                                      deleteFuction: (p0) async {
                                        await itemDelete(doc.id);
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  } else if (snapshot.hasError) {
                    return Container(
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text('Error'),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  itemDelete(id) async {
    FirebaseFirestore.instance.collection('items').doc(id).delete();
  }
}
