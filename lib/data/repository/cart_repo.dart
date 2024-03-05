import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_food_app/models/response/cart_model.dart';
import 'package:z_food_app/utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    // convert obj to string, shared preferences accepts just strings
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.cartList, cart);
    //getCartList(); //print(sharedPreferences.getStringList(AppConstants.cartList));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
      print("Inside cartList " + carts.toString());
    }

    List<CartModel> cartList = [];

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      //cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
    if (kDebugMode) {
      print("The length of history list is ${getCartHistoryList().length}");
    }
    for (int j = 0; j < getCartHistoryList().length; j++) {
      if (kDebugMode) {
        print("The time for the order is ${getCartHistoryList()[j].time}");
      }
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cartList);
  }

  // clear things locally after logout
  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.cartHistoryList);
  }
}
