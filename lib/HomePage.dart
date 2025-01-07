import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/EditListPage.dart';
import 'package:todo_list_flutter/HomeController.dart';
import 'package:todo_list_flutter/models/GetListModel.dart';

import 'models/TodoModel.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(EditListPage());
        },
        shape: CircleBorder(),
        backgroundColor: Colors.purpleAccent[400],
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget myBody() {
    return ListView.builder(
        itemCount: homeController.todoList.obs.value.length,
        itemBuilder: (globalContext, index) {
          return listView(homeController.todoList.obs.value[index], () {
            homeController.updatedItem.value = homeController.todoList[index];
           homeController.updateList();
           Get.to(EditListPage());
          });
        }).paddingSymmetric(horizontal: 10, vertical: 10);
  }

  Widget listView(GetListModel getListModel, GestureTapCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Card(
        color: Colors.deepPurpleAccent,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getListModel.title ??"",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              getListModel.description??"",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(getListModel.date??"",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ).paddingSymmetric(vertical: 15, horizontal: 15),
      ).paddingSymmetric(vertical: 2),
    );
  }
}
