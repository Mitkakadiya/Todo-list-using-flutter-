import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter/EditListController.dart';
import 'package:todo_list_flutter/models/GetListModel.dart';
import 'package:todo_list_flutter/models/TodoModel.dart';

class EditListPage extends StatelessWidget {
  var editController = Get.put(EditListController());
  EditListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          centerTitle: true,
          title: Text(
            'Edit Task',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: myBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (editController.updatedItem.id != null) {
              editController.updatedItem.date =
                  editController.selectedDateValue.value;
              editController.updatedItem.description =
                  editController.descriptionController.text;
              editController.updatedItem.title =
                  editController.titleController.text;
                GetListModel updatedItem =  GetListModel(
                  id: editController.updatedItem.id,
                  title: editController.titleController.text,
                  description: editController.descriptionController.text,
                  date: editController.selectedDateValue.value);
              editController.updateList(updatedItem: updatedItem ,callBack: () {
                Get.back(closeOverlays: true);
              });
            } else {
              editController.createToDoItem(
                  todoModel: TodoModel(
                      title: editController.titleController.text,
                      description: editController.descriptionController.text,
                      date: editController.selectedDateValue.value),
                  callBack: () {
                    Get.back(closeOverlays: true);
                  });
            }
          },
          shape: CircleBorder(),
          backgroundColor: Colors.black,
          child: Icon(
            Icons.save,
            color: Colors.purpleAccent[400],
          ),
        ),
      ),
    );
  }

  Widget myBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: editController.selectedDate.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200));

                if (picked != null &&
                    picked != editController.selectedDate.value) {
                  editController.selectedDate.value = picked;
                  editController.selectedDateValue.value =
                      DateFormat("dd/MM/yyyy")
                          .format(editController.selectedDate.value);
                }
              },
              child: Row(children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.purpleAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(editController.selectedDateValue.value,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ]),
            ),
            TextField(
              controller: editController.titleController,
              decoration: InputDecoration(
                hintText: "Title",
              ),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: editController.descriptionController,
              decoration: InputDecoration(hintText: "Description"),
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
