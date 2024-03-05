import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/controllers/cart_controller.dart';
import 'package:z_food_app/controllers/user_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';

import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/utils/images.dart';
import 'package:z_food_app/views/base/custom_loader.dart';
import 'package:z_food_app/views/base/widgets/account_widget.dart';
import 'package:z_food_app/views/base/widgets/app_icon_widget.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          title: const BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconSize: Dimensions.height30 * 2.5,
                            iconColor: Colors.white,
                            size: Dimensions.height15 * 10,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // name
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel!.name)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  // mobile
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: Colors.black,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel!.phone)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),

                                  // email
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: Colors.black,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel!.email)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),

                                  // address
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: Colors.black,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: const BigText(
                                          text: "Enter your address")),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),

                                  // message~
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: const BigText(text: "Messages")),
                                  SizedBox(
                                    height: Dimensions.width20,
                                  ),

                                  // Logout
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        if (kDebugMode) {
                                          print("Logged out");
                                        }
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout_outlined,
                                        backgroundColor: AppColors.mainColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: const BigText(text: "Logout"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: const DecorationImage(
                                  image: AssetImage(
                                    Images.signInToContinueImg,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                            },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign in",
                              color: Colors.white,
                              size: Dimensions.font26,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }));
  }
}
