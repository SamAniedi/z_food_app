import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:z_food_app/controllers/popular_product_controller.dart';
import 'package:z_food_app/controllers/recommended_product_controller.dart';
import 'package:z_food_app/views/screens/home/widgets/foodpage_body.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../base/widgets/big_text_widget.dart';
import '../../base/widgets/small_text_widget.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: _loadResources,
      
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    BigText(
                      text: "Nigeria",
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "Abuja",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: Dimensions.height45,
                    width: Dimensions.width45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(child: SingleChildScrollView(child: FoodPageBody()))
        ],
      ));
    
  }
}
