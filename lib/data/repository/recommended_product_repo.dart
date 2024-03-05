import 'package:get/get.dart';
import 'package:z_food_app/data/api/api_client.dart';
import 'package:z_food_app/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.recommendedProductUri);
  }
}
