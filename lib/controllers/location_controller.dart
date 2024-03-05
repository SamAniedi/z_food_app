import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:z_food_app/data/repository/location_repo.dart';
import 'package:z_food_app/models/response/adress_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  late GoogleMapController _mapController;
  bool _updateAddressData = true;

  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  // Placemark get placemark => _placemark;
  // Placemark get pickPlaceMark => _pickPlaceMark;







  void setMapController(GoogleMapController mapController) =>
      _mapController = mapController;

  void updatePosition(CameraPosition position, bool fromAddress) {
    if (_updateAddressData) {
      _loading = true;
      update();
      try{
        if(fromAddress){}
        _position = Position(longitude: position.target.longitude, latitude: position.target.latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
      }catch(e){
        print(e);
      }
   
    }
   
  }
}
