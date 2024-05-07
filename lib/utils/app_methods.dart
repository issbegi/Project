import 'package:flutter/material.dart';
import 'package:urbanfootprint/data/shoedata.dart';
import 'package:urbanfootprint/widget/snack_bar.dart';

import '../models/models.dart';

class AppMethods {
  AppMethods._();

  static void addToCart(ShoeModel data, BuildContext context) {
    bool contains = itemsOnBag.contains(data);

    if (contains) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar());
    } else {
      itemsOnBag.add(data);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
    }
  }

  static double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (ShoeModel item in itemsOnBag) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  static double sumOfItemsOnBag() {
    double sumPrice = 0.0;
    for (ShoeModel bagModel in itemsOnBag) {
      sumPrice = sumPrice + bagModel.price;
    }
    return sumPrice;
  }
}
