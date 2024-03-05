// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:z_food_app/utils/dimensions.dart';
import 'package:z_food_app/views/base/widgets/app_icon_widget.dart';
import 'package:z_food_app/views/base/widgets/big_text_widget.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: Row(
        children: [appIcon, SizedBox(width: Dimensions.width20), bigText],
      ),
    );
  }
}
