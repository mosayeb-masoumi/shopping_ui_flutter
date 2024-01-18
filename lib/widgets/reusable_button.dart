import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const ReusableButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Center(
      child: MaterialButton(
        minWidth: size.width * 0.9,
        height: 50,
        color: const Color(0xff141414),
        onPressed: () {
          onTap("tapped");
        },
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
