import 'package:get/get_connect/http/src/response/response.dart';
import 'package:z_food_app/data/api/api_client.dart';
import 'package:z_food_app/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient,
  });


  Future<Response> getUserInfo()async{
    return await apiClient.getData(AppConstants.userInfoUri);
  }
}
