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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: myBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (homeController.updatedItem.value.id != null) {
            homeController.updatedItem.value.date = selectedDateValue.value;
            homeController.updatedItem.value.description =
                descriptionController.text;
            homeController.updatedItem.value.title = titleController.text;
            homeController.updateList();
            Get.to(Homepage());
          } else {
            homeController.createToDoItem(TodoModel(
                title: titleController.text,
                description: descriptionController.text,
                date: selectedDateValue.value));
            Get.to(Homepage());
          }
        },
        shape: CircleBorder(),
        backgroundColor: Colors.purpleAccent[400],
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget myBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
            },
            child: Row(children: [
              Icon(Icons.calendar_month),
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
    );
  }
}
