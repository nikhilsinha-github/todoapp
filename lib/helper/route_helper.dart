import 'package:get/route_manager.dart';
import 'package:todoapp/view/screens/add_todo_screen.dart';
import 'package:todoapp/view/screens/homepage.dart';
import 'package:todoapp/view/screens/splash_screen.dart';

class RouteHelper {
  static const initial = "/";
  static const splash = "/splash";
  static const homepage = "/homepage";
  static const addTodoScreen = "/addtodoscreen";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getHomepageRoute() => homepage;
  static String getAddTodoScreenRoute() => addTodoScreen;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: homepage, page: () => const HomePage()),
    GetPage(name: addTodoScreen, page: () => const AddTodoScreen()),
  ];
}
