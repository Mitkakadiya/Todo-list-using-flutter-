import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/EditListPage.dart';
import 'package:todo_list_flutter/HomeController.dart';
import 'package:todo_list_flutter/models/GetListModel.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getList();
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            centerTitle: true,
            title: Text(
              "To-Do List",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: myBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              homeController.updatedItem.value = GetListModel();
              Get.to(() =>EditListPage());
            },
            shape: CircleBorder(),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.edit,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ));
  }

  Widget myBody() {
    return Container(
      color: Colors.grey[200], // Set your desired background color here
      child: ListView.builder(
          itemCount: homeController.todoList.obs.value.length,
          itemBuilder: (globalContext, index) {
            var currentItem = homeController.todoList[index];
            return Dismissible(
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                homeController.deleteItem(id: currentItem.id);
              },
              key: Key(currentItem.id),
              child:
                  listView(homeController.todoList.obs.value[index], () async {
                homeController.updatedItem.value =
                    homeController.todoList[index];
                Get.to(() =>EditListPage());
              }),
            );
          }).paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }

  Widget listView(GetListModel getListModel, GestureTapCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Card(
        color: Colors.deepPurpleAccent,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getListModel.title ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              getListModel.description ?? "",
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
                Text(getListModel.date ?? "",
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
