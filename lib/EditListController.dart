import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'CommonWidgets.dart';
import 'models/GetListModel.dart';
import 'models/TodoModel.dart';

class EditListController extends GetxController{
  var toDoItem = FirebaseFirestore.instance.collection("list");

  RxList todoList = [].obs;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var updatedItem = GetListModel();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedDateValue = "".obs;

  @override
  void onInit() {
    updatedItem = Get.arguments ?? GetListModel();
    if (titleController.text.isEmpty &&
        updatedItem.title != null) {
      titleController.text =
      updatedItem.title!;
    }
    if (descriptionController.text.isEmpty &&
        updatedItem.description != null) {
      descriptionController.text =
      updatedItem.description!;
    }
    String? modelDate = updatedItem.date;
    if (modelDate != null && modelDate.isNotEmpty) {
      selectedDate.value =
          DateFormat('dd/MM/yyyy').parse(modelDate);
      selectedDateValue.value = modelDate;
    } else {
      selectedDate.value = DateTime.now();
      selectedDateValue.value =
          DateFormat("dd/MM/yyyy").format(DateTime.now());
    }
    super.onInit();
  }

  void createToDoItem({required TodoModel todoModel, Function? callBack}) {
    toDoItem.add(todoModel.toMap()).then(
          (value) {
        if (callBack != null) {
          callBack();
        }
        showSnackBar(title: "Success", message: "Data Created Successfully");
      },
    );
  }

  void updateList({required GetListModel updatedItem ,Function? callBack}) async {
    await toDoItem
        .doc(updatedItem.id)
        .update(TodoModel(
        title: updatedItem.title ?? "",
        description: updatedItem.description ?? "",
        date: updatedItem.date ?? "")
        .toMap())
        .then(
          (value) {
        if (callBack != null) {
          callBack();
        }
        showSnackBar(title: "Success", message: "Data Updated Successfully");
      },
    );
  }


  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

}