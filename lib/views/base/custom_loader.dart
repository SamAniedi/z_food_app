import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("I am printing loading state ${Get.find<AuthController>().isLoading}");
    }
    return Center(
      child: Container(
        height: Dimensions.height20 * 5,
        width: Dimensions.width15 * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            color: AppColors.mainColor),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
