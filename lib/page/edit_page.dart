// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/auth_controler.dart';

import 'package:todo_app/page/hompage.dart';
import 'package:todo_app/util/my_button.dart';

class EditPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const EditPage({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final edittext = TextEditingController();
  final authCon = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text("Edit Task"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              initialValue: authCon.getname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: 'Edit Task',
              ),
              onChanged: (value) {
                authCon.getname = value;
              },
              // controller: edittext,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Mybutton(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Mybutton(
                  text: "Update",
                  onPressed: () async {
                    await fireupdate();
                    Get.to(() => const HomePage());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future fireupdate() async {
    final usercolloction = FirebaseFirestore.instance.collection("items");
    final docRef = usercolloction.doc(widget.documentSnapshot.id);
    try {
      await docRef.update({
        "title": authCon.getname,
      });
    } catch (e) {
      debugPrint("-------erorrr> $e");
    }
  }
}
