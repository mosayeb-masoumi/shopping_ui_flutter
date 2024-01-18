import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with TickerProviderStateMixin {
  late TabController tabController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const Scaffold(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.shopping_cart,
    Icons.message,
  ];

  int _selectedIndex = 0;
  String appBarTitle = "Home";

  setAppBarText(int index) {
    appBarTitle = _selectedIndex == 0
        ? "Home"
        : _selectedIndex == 1
            ? "Search"
            : _selectedIndex == 2
                ? "Cart"
                : "Messages";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.white,

          // just home has actions
          actions: tabController.index==0 ? [
            IconButton(
              onPressed: () {
                setState(() {
                  tabController.index = 1;
                  _selectedIndex = 1;
                  setAppBarText(1);
                });
              },
              icon: const Icon(
                LineIcons.search,
                size: 30,
              ),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {

                setState(() {
                  tabController.index = 2;
                  _selectedIndex = 2;
                  setAppBarText(2);
                });
              },
              icon: const Icon(
                LineIcons.shoppingBag,
                size: 30,
              ),
              color: Colors.black,
            ),
          ]:tabController.index==2?[
            IconButton(
              onPressed: () {
              },
              icon: const Icon(
                LineIcons.user,
                size: 30,
              ),
              color: Colors.black,
            ),
          ]:[],
        ),

        /*** in TabBarView  whenever we click on a tab , that screen will be rendered and start from the start**/
        body: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens),

        /*************  we used IndexedStack instead of   TabBarView
         *  in home page we have a list and when we scroll down the list and then click on other tab then we click on home tab again ,
         *  we will see the home screen not rendered and show the list position where we left the home *************/
        // body: IndexedStack(
        //   index: _selectedIndex,
        //   children: _screens,
        // ),

        bottomNavigationBar: Container(
          // padding: const EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0))),
          child: CustomTabBar(
              controller: tabController,
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTab: (index) {
                setState(() {
                  _selectedIndex = index;
                  setAppBarText(index);
                });
              }),
        ),
      ),
    );
  }
}
