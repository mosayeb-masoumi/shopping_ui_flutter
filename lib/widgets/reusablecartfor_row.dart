import 'package:flutter/material.dart';
import 'package:shopping_ui_flutter/widgets/reusable_text_for_detail.dart';

class ReusableCartForRow extends StatelessWidget {
  final double price;
  final String text;

  const ReusableCartForRow(
      {super.key, required this.price, required this.text});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          ReusableTextForDetail(
            text: price.toString(),
          )
        ],
      ),
    );
  }
}
