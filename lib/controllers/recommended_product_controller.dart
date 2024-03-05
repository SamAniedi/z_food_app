import 'package:get/get.dart';
import 'package:z_food_app/data/repository/recommended_product_repo.dart';
import 'package:z_food_app/models/response/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = []; // initialize to null to prevent duplicates
      _recommendedProductList.addAll(Product.fromJson(response.body)
          .products); // build a model for this to work
      //print(_popularProductList);
      _isLoaded = true;
      update(); // setState
    } else {
      print("Could not get products");
    }
  }
}
