import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:z_food_app/controllers/auth_controller.dart';
import 'package:z_food_app/controllers/location_controller.dart';
import 'package:z_food_app/controllers/user_controller.dart';
import 'package:z_food_app/utils/colors.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(12.8797, 121.7740), zoom: 17);
  late LatLng _initialPosition =
      const LatLng(12.8797, 121.7740); // to change it position later

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController){
        return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: 2, color: Theme.of(context).primaryColor)),
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: (){
                    locationController.updatePosition(_cameraPosition, true);
                  },
                 onCameraMove: ((position)=>_cameraPosition = position),
                 onMapCreated: (GoogleMapController controller){
                    locationController.setMapController(controller);
                 },

                 
                ),
              ],
            ),
          )
        ],
      );
    
      })
    );
  }
}
