import 'dart:async';

import 'package:get/get.dart';
import 'package:todoapp/helper/route_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/util/constants.dart';

class HomepageController extends GetxController {
  RxBool showList = true.obs;
  late Database db;
  RxList<TodoModel> todosList = <TodoModel>[].obs;
  late Timer timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeDB();
  }

  toggleView() {
    showList.value = !(showList.value);
    print(showList.value);
  }

  initializeDB() async {
    String dbPath = await getDatabasesPath();
    print("path: " + dbPath);
    db = await openDatabase('my_db.db');
    print(db.isOpen);
    if (await GetStorage().read(Constants.FIRST_TIME) == null) {
      //yes, user opened this screen first time and no table is there
      //so, we need to create a table
      await db.rawQuery(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, minutes TEXT, seconds TEXT, status TEXT, button_status TEXT)');
      GetStorage().write(Constants.FIRST_TIME, false);
      print("hello");
    } else {
      fetchData();
    }
  }

  fetchData() async {
    List<Map<String, dynamic>> query = await db.rawQuery('SELECT * FROM Todo');
    print(query);
    todosList.clear();
    for (var i = 0; i < query.length; i++) {
      todosList.add(TodoModel.fromJson(query[i]));
    }
    for (var i = 0; i < todosList.length; i++) {
      if (todosList[i].buttonStatus.value == "PAUSE") {
        todosList[i].buttonStatus.value = "RESUME";
        await updateDB(i);
      }
    }
  }

  navigateToAddTodoScreen() async {
    await Get.toNamed(RouteHelper.getAddTodoScreenRoute())!.then((value) {
      if (value != null) {
        fetchData();
      }
    });
  }

  decreaseSecond(int i, String minutes, String seconds) {
    int prevSecond = int.parse(seconds);
    print(prevSecond);
    if (prevSecond != 0) {
      int newSecond = prevSecond - 1;
      todosList[i].seconds.value = newSecond.toString().padLeft(2, '0');
    } else {
      decreaseMinute(i, minutes);
      int newSecond = 59;
      todosList[i].seconds.value = newSecond.toString().padLeft(2, '0');
    }
    print(todosList[i].minutes.value +
        " mins " +
        todosList[i].seconds.value +
        " sec");
  }

  decreaseMinute(int i, String minutes) {
    int prevMinute = int.parse(minutes);
    if (prevMinute > 0) {
      int newMinute = prevMinute - 1;
      todosList[i].minutes.value = newMinute.toString().padLeft(2, '0');
    }
  }

  workOnTodo(int i) {
    if (todosList[i].buttonStatus.value != "PAUSE") {
      todosList[i].status.value = "INPROGRESS";
      todosList[i].buttonStatus.value = "PAUSE";
      startOrResume(true, i);
    } else {
      todosList[i].buttonStatus.value = "RESUME";
      startOrResume(false, i);
    }
  }

  startOrResume(bool start, int i) async {
    if (start) {
      Timer.periodic(const Duration(seconds: 1), (_timer) async {
        timer = _timer;
        decreaseSecond(
            i, todosList[i].minutes.value, todosList[i].seconds.value);
        updateDB(i);
        if (todosList[i].minutes.value == "00" &&
            todosList[i].seconds.value == "00") {
          todosList[i].buttonStatus.value = "DONE";
          todosList[i].status.value = "DONE";
          timer.cancel();
          updateDB(i);
        }
      });
    } else {
      timer.cancel();
      updateDB(i);
    }
  }

  updateDB(int i) async {
    await db.rawUpdate(
        'UPDATE Todo SET minutes = ?, seconds = ?, status = ?, button_status = ? WHERE id = ?',
        [
          todosList[i].minutes.value,
          todosList[i].seconds.value,
          todosList[i].status.value,
          todosList[i].buttonStatus.value,
          todosList[i].id.value
        ]);
    print("done changes");
  }
}
