import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_ui_flutter/methods/add_to_cart.dart';
import 'package:shopping_ui_flutter/model/base_model.dart';
import 'package:shopping_ui_flutter/utils/constants.dart';
import 'package:shopping_ui_flutter/widgets/reusable_button.dart';
import 'package:shopping_ui_flutter/widgets/reusable_text_for_detail.dart';

class DetailScreen extends StatefulWidget {
  final BaseModel data;
  final bool cameFromPopularSection;

  const DetailScreen(
      {super.key, required this.data, required this.cameFromPopularSection});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedSize = 3;
  int selectedColor = 2;

  @override
  Widget build(BuildContext context) {
    BaseModel current = widget.data;
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTopImage(size, textTheme, current),
            buildProductInfo(size, textTheme, current),
            buildSelectedSizeText(textTheme),
            buildSizes(size, textTheme),
            buildSelectedColor(textTheme),
            buildColorList(size, textTheme),
            buildAddToCartButton(current),

          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ))
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
    );
  }

  Widget buildTopImage(Size size, TextTheme textTheme, BaseModel current) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: Stack(
        children: [
          Hero(
            tag: widget.cameFromPopularSection ? current.imageUrl : current.id,
            child: Container(
              width: size.width,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.data.imageUrl),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.12,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ))
        ],
      ),
    );
  }

  Widget buildProductInfo(Size size, TextTheme textTheme, BaseModel current) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    current.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  ReusableTextForDetail(text: current.price.toString())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    current.star.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "${current.review} K+ review",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectedSizeText(TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
        child: Text(
          "Select Size",
          style: textTheme.subtitle1
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSizes(Size size, TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: SizedBox(
        width: size.width * 0.9,
        height: 70,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            itemBuilder: (ctx, index) {
              var current = sizes[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = index;
                  });
                },
                child: AnimatedContainer(
                  margin: const EdgeInsets.all(10.0),
                  duration: const Duration(milliseconds: 200),
                  width: 55,
                  decoration: BoxDecoration(
                      color: selectedSize == index
                          ? primaryColor
                          : Colors.transparent,
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Text(
                      current,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: selectedSize == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildSelectedColor(TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
        child: Text(
          "Select Color",
          style: textTheme.subtitle1
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildColorList(Size size, TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 700),
      child: SizedBox(
        width: size.width ,
        height: 70,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (ctx, index) {
              var current = colors[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: AnimatedContainer(
                  margin: const EdgeInsets.all(5.0),
                  duration: const Duration(milliseconds: 200),
                  width: 55,
                  decoration: BoxDecoration(
                      color: current,
                      border: Border.all(
                          color: selectedColor == index
                              ? primaryColor
                              : Colors.transparent,
                          width: selectedColor == index ? 2 : 1),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              );
            }),
      ),
    );
  }

  Widget buildAddToCartButton(BaseModel data) {
    return FadeInUp(
      delay: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: ReusableButton(text: "Add to cart", onTap: (value){
          AddToCard.addToCard(data, context);
        }) ,
      ),
    );


  }
}
