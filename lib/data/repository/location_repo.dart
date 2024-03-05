import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_food_app/data/api/api_client.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});
}
