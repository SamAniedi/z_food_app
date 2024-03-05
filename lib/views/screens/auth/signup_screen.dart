// ignore_for_file: unused_local_variable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'package:z_food_app/models/body/sign_up_body.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/utils/images.dart';
import 'package:z_food_app/views/base/custom_loader.dart';
import 'package:z_food_app/views/base/show_custom_snackbar.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';
import 'package:z_food_app/views/base/widgets/custom_textfield_widget.dart';
import 'package:z_food_app/views/screens/auth/signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      Images.twitterLogo,
      Images.googleLogo,
      Images.facebookLogo
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Please enter your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Please enter your phone Number",
            title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Please enter your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Please enter a valid email address",
            title: " Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Please enter your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than 6 character",
            title: "Password");
      } else {
        //showCustomSnackBar("Registration complete",title: "registration");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitialRoute());
            print("Registration successful");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      Container(
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage: AssetImage(Images.logo),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: Dimensions.height30,
                      ),

                      // email
                      CustomTextFieldWidget(
                          textController: emailController,
                          hinText: "Email",
                          icon: Icons.email),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      // password
                      CustomTextFieldWidget(
                          textController: passwordController,
                          hinText: "Password",
                          icon: Icons.password_sharp, isObscured: true,),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      // name
                      CustomTextFieldWidget(
                          textController: nameController,
                          hinText: "Name",
                          icon: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      // phone
                      CustomTextFieldWidget(
                          textController: phoneController,
                          hinText: "Phone",
                          icon: Icons.phone),

                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),

                      // sign up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign Up",
                              size: Dimensions.font20 * 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Have an account already?",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                            children: [
                              TextSpan(
                                text: " Sign in",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(const SignInScreen(),
                                      transition: Transition.fade),
                                style: TextStyle(
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),

                      /// sign up options
                      RichText(
                        text: TextSpan(
                          text: "Sign up using either of the following methods",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage:
                                        AssetImage(signUpImages[index]),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
