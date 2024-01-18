import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<IconData> icons;
  final Function(int) onTab;
  final int selectedIndex;
  final bool isBottomIndicator;

  const CustomTabBar(
      {super.key,
      required this.selectedIndex,
      required this.onTab,
      required this.icons,
      this.isBottomIndicator = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicator: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.transparent, width: 3.0),
      )),
      tabs: icons
          .asMap()
          .map(
            (i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == selectedIndex ? Colors.blue : Colors.black45,
                    size: 30.0,
                  ),
                )),
          )
          .values
          .toList(),
      onTap: onTab,
    );
  }
}
