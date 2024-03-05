import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_food_app/controllers/cart_controller.dart';
import 'package:z_food_app/data/repository/popular_products_repo.dart';
import 'package:z_food_app/models/response/cart_model.dart';
import 'package:z_food_app/models/response/products_model.dart';
import 'package:z_food_app/utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // set the quanity
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = []; // initialize to null to prevent duplicates
      _popularProductList.addAll(Product.fromJson(response.body)
          .products); // build a model for this to work
      _isLoaded = true;
      update(); // setState
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("Number of items" + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      //print("Decrement " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "Item count can't be less than 0!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "Item count can't be more than 20!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    // if exist
    // get from storage _inCartItem = 3;

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " and the Quantity is " +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
