import 'package:get/get.dart';
import 'package:z_food_app/views/screens/address/add_address_screen.dart';
import 'package:z_food_app/views/screens/auth/signin_screen.dart';
import 'package:z_food_app/views/screens/cart/cart_screen.dart';
import 'package:z_food_app/views/screens/food/popular_food_detail.dart';
import 'package:z_food_app/views/screens/food/recommended_food_detail.dart';
import 'package:z_food_app/views/screens/home/home_page.dart';
import 'package:z_food_app/views/screens/splash/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash-screen";
  static const String initialRoute = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static const String addAddress = "/add-address";

  static String getSplashScreen() => '$splashScreen';
  static String getInitialRoute() => '$initialRoute';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
    static String getAddressPage() => '$addAddress';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initialRoute, page: () => const HomePage()),
    GetPage(name: signIn, page: () => const SignInScreen(), transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(name: addAddress, page: (){
      return const  AddAddressScreen();
    })
  ];
}
