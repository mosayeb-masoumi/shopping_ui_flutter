import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_ui_flutter/methods/add_to_cart.dart';
import 'package:shopping_ui_flutter/screens/detail_screen.dart';

import '../data/app_data.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    itemsOnSearch = mainList;
  }

  onSearchFun(String search) {
    setState(() {
      itemsOnSearch = mainList
          .where((element) => element.name.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              buildSearchField(size),
              buildSearchedList(textTheme, size)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField(Size size) {
    return FadeInUp(
      delay: const Duration(milliseconds: 50),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.07,
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              onSearchFun(value);
            },
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        itemsOnSearch.clear();
                        itemsOnSearch = mainList;
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    icon: const Icon(Icons.close)),
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600]),
                hintText: "e.g.Casual Jeans",
                border: OutlineInputBorder(
                    //
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13))),
          ),
        ),
      ),
    );
  }

  Widget buildSearchedList(TextTheme textTheme, Size size) {
    return Expanded(
        child: itemsOnSearch.isNotEmpty
            ? GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: itemsOnSearch.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (ctx, index) {
                  BaseModel current = itemsOnSearch[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: (30 * index)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      data: current,
                                      cameFromPopularSection: false,
                                    )));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: size.height * 0.02,
                            right: size.width * 0.01,
                            left: size.width * 0.01,
                            child: Hero(
                              tag: current.id,
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.3,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    image: DecorationImage(
                                        image: AssetImage(current.imageUrl),
                                        fit: BoxFit.cover),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color: Color.fromARGB(61, 0, 0, 0))
                                    ]),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: size.height * 0.04,
                            child: Text(
                              current.name,
                              style: textTheme.subtitle2,
                            ),
                          ),
                          Positioned(
                            bottom: size.height * 0.01,
                            child: RichText(
                                text: TextSpan(
                                    text: "usd ",
                                    style: textTheme.subtitle2?.copyWith(
                                        color: primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                    text: current.price.toString(),
                                    style: textTheme.subtitle2?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ])),
                          ),
                          Positioned(
                            top: size.height * 0.01,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: IconButton(
                                  onPressed: () {
                                    AddToCard.addToCard(current, context);
                                  },
                                  icon: const Icon(
                                    LineIcons.addToShoppingCart,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: const Image(
                      image: AssetImage("assets/images/search_fail.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 250),
                      child: const Text(
                        "No Result Found:(",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ))
                ],
              ));
  }
}
