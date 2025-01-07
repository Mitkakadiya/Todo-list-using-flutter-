import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/EditListPage.dart';
import 'package:todo_list_flutter/HomePage.dart';
import 'models/GetListModel.dart';
import 'models/TodoModel.dart';

class HomeController extends GetxController {
  var toDoItem = FirebaseFirestore.instance.collection("list");

  RxList todoList = [].obs;
  Rx<GetListModel> updatedItem = GetListModel().obs;
  @override
  void onInit() {
    getList();
    print(toDoItem.id);
    super.onInit();
  }

  void createToDoItem(TodoModel todoModel) {
    toDoItem.add(todoModel.toMap());
  }

  void getList() {
     toDoItem.get().then((QuerySnapshot snapShpt) {
       todoList.clear();
      for (var doc in snapShpt.docs) {
        GetListModel model =
            GetListModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        todoList.add(model);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void updateList() {
    toDoItem.doc(updatedItem.value.id).update(
        TodoModel(title: updatedItem.value.title??"", description: updatedItem.value.description??"", date: updatedItem.value.date??"")
            .toMap());
  }
}
