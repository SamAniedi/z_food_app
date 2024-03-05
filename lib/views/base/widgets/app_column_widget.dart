import 'package:flutter/material.dart';
import 'package:z_food_app/utils/colors.dart';
import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';
import 'package:z_food_app/views/base/widgets/icon_and_text_widget.dart';
import 'package:z_food_app/views/base/widgets/small_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const SmallText(text: "4.5"),
            const SizedBox(
              width: 10,
            ),
            const SmallText(text: "1556"),
            const SizedBox(
              width: 10,
            ),
            const SmallText(text: "comments")
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
