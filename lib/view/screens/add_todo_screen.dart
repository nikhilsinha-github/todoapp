import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/add_todo_controller.dart';
import 'package:todoapp/view/widget/custom_text_form.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Get.put(AddTodoController());
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add a todo"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Obx(() {
            AddTodoController addTodoController = Get.find<AddTodoController>();
            return Column(
              children: [
                CustomTextForm(
                  textEditingController: addTodoController.titleController,
                  hintText: "Title",
                  input: addTodoController.title,
                ),
                CustomTextForm(
                  textEditingController:
                      addTodoController.descriptionController,
                  hintText: "Description (optional)",
                  input: addTodoController.description,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            addTodoController.minutes.value.padLeft(2, '0')[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            addTodoController.minutes.value.padLeft(2, '0')[1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text("m"),
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => addTodoController.increaseMinute(),
                              onLongPress: () =>
                                  addTodoController.increaseMinute(),
                              onTapDown: (d) =>
                                  addTodoController.increaseMinute(),
                              child: Container(
                                color: Colors.grey[300],
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.expand_less,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () => addTodoController.decreaseMinute(),
                              child: Container(
                                color: Colors.grey[300],
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.expand_more,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: Text(
                          ":",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            addTodoController.seconds.value.padLeft(2, '0')[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            addTodoController.seconds.value.padLeft(2, '0')[1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text("s"),
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => addTodoController.increaseSecond(),
                              child: Container(
                                color: Colors.grey[300],
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.expand_less,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () => addTodoController.decreaseSecond(),
                              child: Container(
                                color: Colors.grey[300],
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.expand_more,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onPressed: () => addTodoController.validateData(),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
