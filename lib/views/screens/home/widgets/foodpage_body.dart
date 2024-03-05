import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/popular_product_controller.dart';
import 'package:z_food_app/controllers/recommended_product_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'package:z_food_app/models/response/products_model.dart';
import 'package:z_food_app/utils/app_constants.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/views/base/widgets/app_column_widget.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';
import 'package:z_food_app/views/base/widgets/small_text_widget.dart';

import '../../../../utils/dimensions.dart';
import '../../../base/widgets/icon_and_text_widget.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Top Seller"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const SmallText(text: "Most popular"),
              ),
            ],
          ),
        ),

        
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index, "homepage"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: Dimensions.width20,
                            left: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            // image section
                            Container(
                              height: Dimensions.listViewImg,
                              width: Dimensions.listViewImg,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.baseUrl +
                                      AppConstants.uploadUrl +
                                      recommendedProduct
                                          .recommendedProductList[index].img!),
                                ),
                              ),
                            ),

                            // text section
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextConSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      const SmallText(
                                          text:
                                              "The Unique African Experience"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.iconColor2),
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "32 min",
                                              iconColor: AppColors.iconColor1),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItems(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale =
          1 - (_currentPageValue - index).abs() * (1 - _scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    } else {
      var distanceToCurrentPage = (index - _currentPageValue).abs();
      var currentScale =
          _scaleFactor + (1 - _scaleFactor) * (1 - distanceToCurrentPage);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,"homepage"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Colors.red : Colors.green,
                image: DecorationImage(
                    image: NetworkImage(AppConstants.baseUrl +
                        AppConstants.uploadUrl +
                        popularProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.mainColor,
                        blurRadius: 10.0,
                        offset: Offset(0, 5))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    right: 15, left: 15, top: Dimensions.height15),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
