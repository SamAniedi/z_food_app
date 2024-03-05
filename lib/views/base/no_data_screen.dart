// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/utils/images.dart';

class NoDataScreen extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataScreen({
    Key? key,
    required this.text,
    this.imgPath = Images.emptyCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: Dimensions.noDataImgHeight,
          width: Dimensions.noDataImgWidth,
        ),
        SizedBox(
          height: Dimensions.sizedBoxSmallW,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
