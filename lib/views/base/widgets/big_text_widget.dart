// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  const BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        maxLines: 1,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size == 0 ? Dimensions.font20 : size,
        ));
  }
}
