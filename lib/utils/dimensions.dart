import 'package:get/get.dart';

class Dimensions {
  // the development device width is 411.42857142857144
  // the development screen height was 867.4285714285714/220 = 3.94

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // the development screen height was 867.4285714285714/220 = 3.94
  static double pageViewContainer = screenHeight / 3.94;
  static double pageView = screenHeight / 2.71;
  static double pageViewTextContainer = screenHeight / 7.23;

  // responsive height for padding and margin
  static double height10 = screenHeight / 86.74;
  static double height15 = screenHeight / 57.82;
  static double height20 = screenHeight / 43.37;
  static double height30 = screenHeight / 28.91;
  static double height45 = screenHeight / 19.276;

  // responsive width for padding and margin
  static double width10 = screenWidth / 41.14;
  static double width15 = screenWidth / 27.42;
  static double width20 = screenWidth / 20.57;
  static double width30 = screenWidth / 13.71;
  static double width45 = screenWidth / 9.14;

  // font
  static double font16 = screenHeight / 54.21;
  static double font20 = screenHeight / 43.37;
  static double font26 = screenHeight / 33.36;

  // responsive radius
  static double radius15 = screenHeight / 57.82;
  static double radius20 = screenHeight / 43.37;
  static double radius30 = screenHeight / 28.91;

  // icon size
  static double iconSize24 = screenHeight / 36.14;
  static double iconSize16 = screenHeight / 54.21;

  // listview size
  // the development device width is 411.42857142857144/ 120 container size
  static double listViewImg = screenWidth / 3.42;
  static double listViewTextConSize = screenWidth / 4.11;

  // popualar food details
  static double popularFoodImageSize = screenHeight / 2.478;

  // bottom Nav height
  static double bottomNavBarHeight = screenHeight / 7.228;

  // expandable text;
  static double ExpandableTextHeight = screenHeight / 5.78; // 150

  // splashScreen
  static double splashImg = screenWidth / 1.645;

  // no data screen
  static double noDataImgHeight = screenHeight / 5.78;
  static double noDataImgWidth = screenWidth / 2.74;

  // sized box
  static double sizedBoxSmallW = screenHeight / 41.14; // 10
}
