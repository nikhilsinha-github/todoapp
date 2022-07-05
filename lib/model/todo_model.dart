import 'package:get/get.dart';

class TodoModel {
  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.minutes,
    required this.seconds,
    required this.status,
  });
  RxString id = "".obs;
  RxString title = "".obs;
  RxString description = "".obs;
  RxString minutes = "".obs;
  RxString seconds = "".obs;
  RxString status = "".obs;
  RxString buttonStatus = "".obs;

  TodoModel.fromJson(Map<String, dynamic> json) {
    id.value = json['id'].toString();
    title.value = json['title'].toString();
    description.value = json['description'].toString();
    minutes.value = json['minutes'].toString();
    seconds.value = json['seconds'].toString();
    status.value = json['status'].toString();
    buttonStatus.value = json['button_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['minutes'] = minutes;
    _data['seconds'] = seconds;
    _data['status'] = status;
    _data['button_status'] = buttonStatus;
    return _data;
  }
}
