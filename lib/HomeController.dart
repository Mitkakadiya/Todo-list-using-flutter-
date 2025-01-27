import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/CommonWidgets.dart';
import 'models/GetListModel.dart';

class HomeController extends GetxController {
  var toDoItem = FirebaseFirestore.instance.collection("list");

  RxList todoList = [].obs;
  Rx<GetListModel> updatedItem = GetListModel().obs;
  @override
  void onInit() {
    print('called');
    getList();
    super.onInit();
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
