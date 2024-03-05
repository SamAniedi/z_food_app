import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/cart_controller.dart';
import 'package:z_food_app/controllers/popular_product_controller.dart';
import 'package:z_food_app/controllers/recommended_product_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'helper/dependencies.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food App",
          //home: const SignInScreen(),
         // home: const SplashScreen(),
         initialRoute: RouteHelper.getSplashScreen(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
