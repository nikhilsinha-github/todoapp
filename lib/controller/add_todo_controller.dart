import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoController extends GetxController {
  RxString title = "".obs;
  RxString description = "".obs;
  RxString minutes = "10".obs;
  RxString seconds = "00".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Database db;

  @override
  void onInit() {
    super.onInit();
    initializeDB();
  }

  initializeDB() async {
    String dbPath = await getDatabasesPath();
    print("path: " + dbPath);
    db = await openDatabase('my_db.db');
    print(db.isOpen);
  }

  increaseMinute() {
    int prevMinute = int.parse(minutes.value);
    if (prevMinute < 9) {
      int newMinute = prevMinute + 1;
      minutes.value = newMinute.toString().padLeft(2, '0');
    } else if (prevMinute == 9) {
      roundOffTime();
    }
  }

  decreaseMinute() {
    int prevMinute = int.parse(minutes.value);
    if (prevMinute > 0) {
      int newMinute = prevMinute - 1;
      minutes.value = newMinute.toString().padLeft(2, '0');
    }
  }

  roundOffTime() {
    int prevMinute = int.parse(minutes.value);
    int newMinute = prevMinute + 1;
    minutes.value = newMinute.toString().padLeft(2, '0');
    int newSecond = 0;
    seconds.value = newSecond.toString().padLeft(2, '0');
  }

  increaseSecond() {
    int prevMinute = int.parse(minutes.value);
    int prevSecond = int.parse(seconds.value);
    if (prevSecond < 59 && prevMinute < 10) {
      int newSecond = prevSecond + 1;
      seconds.value = newSecond.toString().padLeft(2, '0');
    } else if (prevMinute != 10) {
      roundOffTime();
    }
  }

  decreaseSecond() {
    int prevSecond = int.parse(seconds.value);
    if (prevSecond != 0) {
      int newSecond = prevSecond - 1;
      seconds.value = newSecond.toString().padLeft(2, '0');
    } else {
      decreaseMinute();
      int newSecond = 59;
      seconds.value = newSecond.toString().padLeft(2, '0');
    }
  }

  validateData() async {
    if (title.value == "") {
      Get.snackbar(
        "Title cannot be empty",
        "Please enter title",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (minutes.value == "00" && seconds.value == "00") {
      Get.snackbar(
        "Total duration cannot be 0",
        "Please select some duration",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      addTodo();
    }
  }

  addTodo() async {
    dynamic query = await db.rawInsert(
        "INSERT INTO Todo(title, description, minutes, seconds, status, button_status) VALUES('${title.value}','${description.value}','${minutes.value}','${seconds.value}', 'TODO', 'START')");
    print(query);
    if (query != 0) {
      Get.back(result: true);
      Get.snackbar(
        "SUCCESS",
        "Todo added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
