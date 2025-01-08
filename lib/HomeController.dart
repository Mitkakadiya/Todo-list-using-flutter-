import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/CommonWidgets.dart';
import 'models/GetListModel.dart';
import 'models/TodoModel.dart';

class HomeController extends GetxController {
  var toDoItem = FirebaseFirestore.instance.collection("list");

  RxList todoList = [].obs;
  Rx<GetListModel> updatedItem = GetListModel().obs;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  void createToDoItem({required TodoModel todoModel,Function? callBack}) {
    toDoItem.add(todoModel.toMap()).then((value) {
      if(callBack != null ){
        callBack();
      }
      showSnackBar(title: "Success", message: "Data Created Successfully");
    },);
  }

  void getList() async {
    toDoItem.snapshots().listen((QuerySnapshot snapshot) {
      todoList.clear();
      for (var doc in snapshot.docs) {
        GetListModel model =
            GetListModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        todoList.add(model);
      }
    });
    print(todoList);
  }

  void updateList({Function? callBack}) async {
    await toDoItem
        .doc(updatedItem.value.id)
        .update(TodoModel(
                title: updatedItem.value.title ?? "",
                description: updatedItem.value.description ?? "",
                date: updatedItem.value.date ?? "")
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

  void deleteItem({required String id, Function? callBack}) async {
    await toDoItem.doc(id).delete().then(
      (value) {
        if (callBack != null) {
          callBack();
        }
        showSnackBar(title: "Success", message: "Data Deleted Successfully");
      },
    );
  }
}
