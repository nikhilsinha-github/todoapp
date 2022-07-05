import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/homepage_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.put(HomepageController());
    return Scaffold(
      key: _globalKey,
      backgroundColor: const Color(0xFFF5F2F2),
      appBar: AppBar(
        elevation: 0,
        title: const Text("TODO APP"),
        centerTitle: false,
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () => homepageController.toggleView(),
              icon: homepageController.showList.isTrue
                  ? const Icon(Icons.grid_4x4)
                  : const Icon(Icons.list),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return homepageController.todosList.isEmpty
              ? const Center(
                  child: Text(
                    "No Todo found!\nCreate a new todo",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : (homepageController.showList.isTrue
                  ? ListView.builder(
                      itemCount: homepageController.todosList.length,
                      itemBuilder: (context, index) {
                        return todoCard(homepageController, index, "LIST");
                      })
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.95),
                      itemCount: homepageController.todosList.length,
                      itemBuilder: (context, index) {
                        return todoCard(homepageController, index, "GRID");
                      }));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7491b9),
        onPressed: () => homepageController.navigateToAddTodoScreen(),
        tooltip: 'Add todo',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget todoCard(
      HomepageController homepageController, int index, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: type == "LIST"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title: " +
                                homepageController.todosList[index].title.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Description: " +
                                homepageController
                                    .todosList[index].description.value,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          Obx(
                            () => Text(
                              "Remaining duration: " +
                                  homepageController
                                      .todosList[index].minutes.value +
                                  " minutes " +
                                  homepageController
                                      .todosList[index].seconds.value +
                                  " seconds",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "Status: " +
                                  homepageController
                                      .todosList[index].status.value,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          homepageController.todosList[index].status.value !=
                                  "DONE"
                              ? TextButton(
                                  onPressed: () {
                                    if (homepageController
                                            .todosList[index].status.value !=
                                        "DONE") {
                                      homepageController.workOnTodo(index);
                                    }
                                  },
                                  child: Text(homepageController
                                      .todosList[index].buttonStatus.value),
                                )
                              : Checkbox(
                                  value: homepageController
                                              .todosList[index].status.value ==
                                          "TODO"
                                      ? false
                                      : true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  onChanged: (val) {},
                                ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title: " +
                          homepageController.todosList[index].title.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Description: " +
                          homepageController.todosList[index].description.value,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Remaining duration: " +
                            homepageController.todosList[index].minutes.value +
                            " minutes " +
                            homepageController.todosList[index].seconds.value +
                            " seconds",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Status: " +
                            homepageController.todosList[index].status.value,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          homepageController.todosList[index].status.value !=
                                  "DONE"
                              ? TextButton(
                                  onPressed: () {
                                    if (homepageController
                                            .todosList[index].status.value !=
                                        "DONE") {
                                      homepageController.workOnTodo(index);
                                    }
                                  },
                                  child: Text(homepageController
                                      .todosList[index].buttonStatus.value),
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
