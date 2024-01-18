import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:shopping_ui_flutter/data/app_data.dart';
import 'package:shopping_ui_flutter/model/base_model.dart';

class AddToCard {
  static void addToCard (BaseModel data , BuildContext context){

    // this variable save a true or false value
    bool contains = itemsOnCart.contains(data);
    if(contains == true){
      //data is available in list
      const AdvanceSnackBar(
        textSize: 16,
        bgColor: Colors.red,
        message: "You hav added this item to cart before",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }else {

      itemsOnCart.add(data);
      const AdvanceSnackBar(
        textSize: 16,
        bgColor: Colors.green,
        message: "successfully added to cart",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}