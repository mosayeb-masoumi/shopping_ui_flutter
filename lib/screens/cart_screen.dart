import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_ui_flutter/data/app_data.dart';
import 'package:shopping_ui_flutter/model/base_model.dart';
import 'package:shopping_ui_flutter/widgets/reusable_button.dart';
import 'package:shopping_ui_flutter/widgets/reusablecartfor_row.dart';

import '../utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void onDelete(BaseModel data){
    setState(() {
      if(itemsOnCart.length == 1){
        itemsOnCart.clear();
      }else {
        itemsOnCart.removeWhere((element) => element.id == data.id);
      }
    });
  }

  double calculateTotalPrice(){
    double total = 0.0;
    if(itemsOnCart.isEmpty){
      total = 0.0;
    }else{
      for(BaseModel data in itemsOnCart){
        total = total + (data.price * data.value);
      }
    }
    return total;
  }

  double calculateShipping(){
      double shipping = 0.0;
      if(itemsOnCart.isEmpty){
        shipping = 0.0;
        return shipping;
      }else if(itemsOnCart.length <= 4){
        shipping = 25.99;
        return shipping;
      }else{
        shipping = 88.99;
        return shipping;
      }
  }

  int calculateSubTotal(){
    int subTotal= 0;
    if(itemsOnCart.isEmpty){
      subTotal = 0;
    }else{
      for(BaseModel data in itemsOnCart){
        subTotal = subTotal + data.price.round();
        subTotal = subTotal - 160;
      }
    }
    return subTotal <0 ? 0: subTotal;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            buildPurchasedCart(size, textTheme),
            buildProductPrices(size),
          ],
        ),
      ),
    );
  }

  Widget buildPurchasedCart(Size size, TextTheme textTheme) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: itemsOnCart.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: itemsOnCart.length,
              itemBuilder: (ctx, index) {
                var current = itemsOnCart[index];
                return buildCartListItem(size, current, textTheme, index);
              })
          : buildEmptyListPlaceholder(size),
    );
  }

  Widget buildCartListItem(
      Size size, BaseModel current, TextTheme textTheme, int index) {
    return FadeInUp(
      delay: Duration(milliseconds: (50 * index)),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: size.width,
        height: size.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(size, current),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          current.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {
                              onDelete(current);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: "usd ",
                          style: textTheme.subtitle2?.copyWith(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: current.price.toString(),
                          style: textTheme.subtitle2?.copyWith(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        )
                      ])),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Size = ${sizes[3]}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    width: size.width * 0.4,
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setState(() {
                                if(current.value > 1){
                                  current.value -- ;
                                }else {
                                  onDelete(current);
                                  current.value =1;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            current.value.toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(4),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setState(() {
                                current.value > 0 ?
                                current.value ++ : null;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(Size size, BaseModel current) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: size.width * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(current.imageUrl), fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: Color.fromARGB(61, 0, 0, 0))
          ]),
    );
  }

  Widget buildProductPrices(Size size) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
          child: Column(
            children: [
              FadeInUp(
                  delay: const Duration(milliseconds: 350),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Promo/Student Code or Vouchers",
                          style: TextStyle(fontSize: 16)),
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: ReusableCartForRow(price: calculateSubTotal().toDouble(), text: "Sub total")),
              FadeInUp(
                  delay: const Duration(milliseconds: 450),
                  child: ReusableCartForRow(price: calculateShipping(), text: "Shipping")),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
              ),
              FadeInUp(
                  delay: const Duration(milliseconds: 550),
                  child: ReusableCartForRow(price: calculateTotalPrice(), text: "Total")),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReusableButton(
                      text: "Check out",
                      onTap: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmptyListPlaceholder(Size size) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        FadeInUp(
            delay: const Duration(milliseconds: 100),
            child: const Image(
              image: AssetImage("assets/images/empty.png"),
              fit: BoxFit.cover,
            )),
        const SizedBox(
          height: 10.0,
        ),
        FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: const Text(
              "Your cart is empty right now :(",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )),
      ],
    );
  }
}
