import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter/models/TodoModel.dart';

import 'HomeController.dart';
import 'HomePage.dart';

class EditListPage extends StatelessWidget {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var homeController = Get.put(HomeController());

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedDateValue = "".obs;

  EditListPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? modelDate = homeController.updatedItem.value.date;
    if (modelDate != null && modelDate.isNotEmpty) {
      selectedDate.value = DateFormat('dd/MM/yyyy').parse(modelDate);
      selectedDateValue.value = modelDate;
    } else {
      // Default to current date
      selectedDate.value = DateTime.now();
      selectedDateValue.value = DateFormat("dd/MM/yyyy").format(DateTime.now());
    }
    titleController.text = homeController.updatedItem.value.title ?? "";
    descriptionController.text =
        homeController.updatedItem.value.description ?? "";
    return Obx(
      () => Scaffold(
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
            if (homeController.updatedItem.value.id != null) {
              homeController.updatedItem.value.date = selectedDateValue.value;
              homeController.updatedItem.value.description =
                  descriptionController.text;
              homeController.updatedItem.value.title = titleController.text;
              homeController.updateList(callBack: () {
                Get.back(closeOverlays: true);
              });
            } else {
              homeController.createToDoItem(
                  todoModel: TodoModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: selectedDateValue.value),
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200));

                if (picked != null && picked != selectedDate.value) {
                  selectedDate.value = picked;
                  selectedDateValue.value =
                      DateFormat("dd/MM/yyyy").format(selectedDate.value);
                }
                print(selectedDateValue.value);
              },
              child: Row(children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.purpleAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(selectedDateValue.value,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ]),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
              ),
              maxLines: 1,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: descriptionController,
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
