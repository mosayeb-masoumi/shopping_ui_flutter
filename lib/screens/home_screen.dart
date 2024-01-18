import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_ui_flutter/data/app_data.dart';
import 'package:shopping_ui_flutter/model/base_model.dart';
import 'package:shopping_ui_flutter/model/categories_model.dart';
import 'package:shopping_ui_flutter/utils/constants.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;

  bool cameFromPopularSection = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 2,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var theme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopTwoTexts(theme),
              buildCategories(size, theme),
              buildPagerView(size, theme, _controller),
              buildMostPopularText(size, theme),
              buildMostPopularContent(size, theme)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopTwoTexts(TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 150),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "Find your",
                    style: theme.headline2,
                    children: [
                      TextSpan(
                          text: " Style",
                          style: theme.headline1?.copyWith(
                              color: primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold))
                    ])),
            RichText(
                text: const TextSpan(
                    text: "be more beatiful with our",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: " suggestions :)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ])),
          ],
        ),
      ),
    );
  }

  Widget buildCategories(Size size, TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.only(top: 7.0),
        width: size.width,
        height: size.height * 0.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (ctx, index) {
              CategoriesModel current = categories[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(current.imageUrl),
                      radius: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      current.title,
                      style: theme.subtitle2,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget buildPagerView(Size size, TextTheme theme, PageController controller) {
    return FadeInUp(
      delay: const Duration(milliseconds: 250),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.5,
        child: PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: mainList.length,
            itemBuilder: (ctx, index) {
              BaseModel data = mainList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(data: data,
                                    cameFromPopularSection: false)));
                  },
                  child: view(size, data, theme, index));
            }),
      ),
    );
  }

  Widget view(Size size, BaseModel data, TextTheme theme, int index) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: _buildPagerItem(size, data, theme),
          );
        });
  }

  Widget _buildPagerItem(Size size, BaseModel data, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  image: DecorationImage(
                      image: AssetImage(data.imageUrl), fit: BoxFit.cover),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(61, 0, 0, 0))
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              data.name,
              style: theme.headline6,
            ),
          ),
          RichText(
              text: TextSpan(
                  text: "usd ",
                  style: theme.subtitle2?.copyWith(
                      color: primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: data.price.toString(),
                      style: theme.subtitle2
                          ?.copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                    )
                  ])),
        ],
      ),
    );
  }

  Widget buildMostPopularText(Size size, TextTheme theme) {
    return FadeInUp(
        delay: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Popular",
                style: theme.subtitle1,
              ),
              Text(
                "See All",
                style: theme.subtitle1?.copyWith(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildMostPopularContent(Size size, TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: SizedBox(
          width: size.width,
          height: size.height * 0.44,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: mainList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            itemBuilder: (ctx, index) {
              BaseModel current = mainList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(
                                  data: current,
                                  cameFromPopularSection: true
                              )));
                },
                child: Column(
                  children: [
                    Hero(
                      tag: current.imageUrl,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(
                        current.name,
                        style: theme.subtitle2,
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "usd ",
                            style: theme.subtitle2?.copyWith(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: current.price.toString(),
                                style: theme.subtitle2?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              )
                            ])),
                  ],
                ),
              );
            },
          )),
    );
  }
}
