import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/helper/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamedUntil(RouteHelper.getHomepageRoute(), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          "https://lh3.googleusercontent.com/JkWOx6n76rv1GlXTjXuWDJTENGzsBWl1hPEvGWofZwBjWqPNsbWB7jjda7XDCqRinTw",
          height: 250,
        ),
      ),
    );
  }
}
