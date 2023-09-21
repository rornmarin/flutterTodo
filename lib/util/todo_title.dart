import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/auth_controler.dart';
import 'package:todo_app/page/edit_page.dart';

class ToDoTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFuction;
  Function()? onTap;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    this.deleteFuction,
    required this.documentSnapshot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final authCon = Get.put(AuthController());
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Flexible(
        fit: FlexFit.loose,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              const SizedBox(width: 10),
              SlidableAction(
                label: "Delete",
                onPressed: deleteFuction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(1, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: taskCompleted ? Colors.red : Colors.black,
                  ),
                  SizedBox(
                    width: 220,
                    child: Expanded(
                      child: Text(
                        taskName,
                        style: TextStyle(
                            color: taskCompleted ? Colors.red : Colors.black,
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      authCon.getname = documentSnapshot['title'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditPage(documentSnapshot: documentSnapshot),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
