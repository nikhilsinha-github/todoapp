import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/helper/route_helper.dart';
import 'package:todoapp/util/constants.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.PRIMARY_COLOR,
        primarySwatch: const MaterialColor(0xFF17478b, {
          50: Color.fromRGBO(23, 71, 139, .1),
          100: Color.fromRGBO(23, 71, 139, .2),
          200: Color.fromRGBO(23, 71, 139, .3),
          300: Color.fromRGBO(23, 71, 139, .4),
          400: Color.fromRGBO(23, 71, 139, .5),
          500: Color.fromRGBO(23, 71, 139, .6),
          600: Color.fromRGBO(23, 71, 139, .7),
          700: Color.fromRGBO(23, 71, 139, .8),
          800: Color.fromRGBO(23, 71, 139, .9),
          900: Color.fromRGBO(23, 71, 139, 1),
        }),
      ),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
