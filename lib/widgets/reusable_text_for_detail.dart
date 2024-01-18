import 'package:flutter/material.dart';

import '../model/base_model.dart';
import '../utils/constants.dart';

class ReusableTextForDetail extends StatelessWidget {
  final String text;
  const ReusableTextForDetail({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return RichText(
        text: TextSpan(
            text: "usd ",
            style: textTheme.subtitle2?.copyWith(
                color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
            children: [
          TextSpan(
            text: text,
            style: textTheme.subtitle2
                ?.copyWith(fontSize: 19, fontWeight: FontWeight.w500),
          )
        ]));
  }
}
