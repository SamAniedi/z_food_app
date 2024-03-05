import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/helper/route_helper.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/utils/images.dart';
import 'package:z_food_app/views/base/custom_loader.dart';
import 'package:z_food_app/views/base/show_custom_snackbar.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';
import 'package:z_food_app/views/base/widgets/custom_textfield_widget.dart';
import 'package:z_food_app/views/screens/auth/signup_screen.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

     if (phone.isEmpty) {
        showCustomSnackBar("Please enter your mobile number",
            title: "Email address");
      } else if (!GetUtils.isNum(phone)) {
        showCustomSnackBar("Please enter a valid email address",
            title: " Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Please enter your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than 6 character",
            title: "Password");
      } else {
       
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            //Get.toNamed(RouteHelper.getInitialRoute());
            Get.toNamed(RouteHelper.cartPage);
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
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

            // welcome message
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimensions.font20 * 3.5,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: Dimensions.font20, color: Colors.grey[500]
                        // fontWeight: FontWeight.bold
                        ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),

            // email
            CustomTextFieldWidget(
                textController: phoneController,
                hinText: "Mobile Number",
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

           
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                    text: "Sign in to your account",
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimensions.font20),
                  ),
                ),
               SizedBox(width: Dimensions.width20,),
              ],
            ),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),

            // sign in button
            GestureDetector(
              onTap: (){
                _login(authController);
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor),
                child: Center(
                  child: BigText(
                    text: "Sign In",
                    size: Dimensions.font20 * 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Dimensions.height20 * 2,
            ),

            /// sign up options
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimensions.font20),
                  children: [
                    TextSpan(
                      text: " Create",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(const SignUpScreen(), transition: Transition.fade),
                      style: TextStyle(
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ],
        ),
      ):const CustomLoader();
   
      })
    );
  }
}
