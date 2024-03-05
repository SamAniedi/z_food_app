import 'package:get/get.dart';
import 'package:z_food_app/data/repository/user_repo.dart';
import 'package:z_food_app/models/response/response_model.dart';
import 'package:z_food_app/models/response/user_model.dart';


class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  

  UserController({required this.userRepo});

  bool _isLoading = false;
  UserModel? _userModel;
  
  bool get isLoading => _isLoading;

  
  UserModel? get userModel =>_userModel;

  // retrieve user info from db
  Future<ResponseModel> getUserInfo() async {
  
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print(response.body.toString());

    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successful");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }
    update();

    //_isLoading = false;
    
   return responseModel;
  }
    
 


}
