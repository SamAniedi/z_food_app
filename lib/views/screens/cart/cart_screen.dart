import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/controllers/cart_controller.dart';
import 'package:z_food_app/controllers/location_controller.dart';
import 'package:z_food_app/controllers/popular_product_controller.dart';
import 'package:z_food_app/controllers/recommended_product_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'package:z_food_app/utils/app_constants.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/views/base/no_data_screen.dart';
import 'package:z_food_app/views/base/widgets/app_icon_widget.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';
import 'package:z_food_app/views/base/widgets/small_text_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // header
          Positioned(
            top: Dimensions.height30 * 2,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitialRoute());
                  },
                  child: AppIcon(
                    icon: Icons.home_sharp,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                )
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: cartList.length,
                                itemBuilder: (_, index) {
                                  return SizedBox(
                                    width: double.maxFinite,
                                    height: Dimensions.height20 * 5,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(
                                                      cartList[index].product!);

                                              if (recommendedIndex < 0) {
                                                Get.snackbar("Product History",
                                                    "Product is not available, can't review",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.width20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.baseUrl +
                                                          AppConstants
                                                              .uploadUrl +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black54),
                                              const SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        ' \$ ${cartController.getItems[index].price.toString()}',
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                            print("Tapped");
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                });
                          })),
                    ),
                  )
                : const NoDataScreen(text: "Your cart is currently empty");
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: 120,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2))),
          child: cartController.getItems.length > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                              text:
                                  '\$ ${cartController.totalAmount.toString()}'),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          print("Logged in");
                          if(Get.find<LocationController>().addressList.isEmpty){
                            Get.toNamed(RouteHelper.getAddressPage());
                          }
                         
                        }else{
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: const BigText(
                          text: "Check out",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
