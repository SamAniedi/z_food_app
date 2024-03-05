import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/popular_product_controller.dart';
import 'package:z_food_app/controllers/recommended_product_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'package:z_food_app/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(const Duration(seconds: 3), () {
      Get.offNamed(RouteHelper.initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                Images.logo,
                width: 250,
              )))
        ],
      ),
    );
  }
}
