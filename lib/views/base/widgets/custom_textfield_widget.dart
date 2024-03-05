// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:z_food_app/utils/dimensions.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final bool isObscured;
  final String hinText;
  final IconData icon;

  const CustomTextFieldWidget({
    Key? key,
    required this.textController,
    this.isObscured = false,
    required this.hinText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.2))
            ], borderRadius: BorderRadius.circular(Dimensions.radius15)),
            child: TextField(
              obscureText: isObscured?true:false,
              controller: textController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintText: hinText,
                  prefixIcon:   Icon(
                    icon,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.white)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          )
       ;
  }
}
