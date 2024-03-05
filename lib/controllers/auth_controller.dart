import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:z_food_app/data/repository/auth_repo.dart';
import 'package:z_food_app/models/body/sign_up_body.dart';
import 'package:z_food_app/models/response/response_model.dart';
import 'package:z_food_app/views/base/show_custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // handle user registration and save the token using a response model
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      showCustomSnackBar(response.statusText.toString());
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
    // user login
  Future<ResponseModel> login(String phone, String password) async { //changed email
      
    _isLoading = true;
    update();

    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
        if (kDebugMode) {
          print("backend token");
        }
      authRepo.saveUserToken(response.body["token"]);
      if(kDebugMode){
        print("${response.body['token']}");
      }
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

    // save the number and password locally
  void saveUserNumberAndPassword(String number, String password){
    authRepo.saveUserNumberAndPassword(number, password);
    }

  bool userLoggedIn()  {
    return  authRepo.userLoggedIn();
  }


  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
 


}
