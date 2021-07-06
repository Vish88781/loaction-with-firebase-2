/*


import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/src/permission_enums.dart';
import 'dart:async';

class MapSample extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return MapSampleState();
  }

}

class MapSampleState extends State{

  bool show = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MyMap(),
    );
  }

}
class MyMap extends StatefulWidget{

  @override
  State createState() {
    // TODO: implement createState
    return MyMapState();
  }

}

class MyMapState extends State{
  LatLng latlong=null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller ;
  Set<Marker> _markers={};
  TextEditingController locationController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraPosition=CameraPosition(target: LatLng(0, 0),zoom: 10.0);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Stack(
      children: [
        (latlong!=null) ?GoogleMap(
          initialCameraPosition: _cameraPosition,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          minMaxZoomPreference: MinMaxZoomPreference(0,25),
          mapType: MapType.normal,


          onMapCreated: (GoogleMapController controller){
            _controller=(controller);
            _controller.animateCamera(

                CameraUpdate.newCameraPosition(_cameraPosition));
          },

          markers:_markers ,

        ):Container(),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height:80.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(
              maxLines: 3,

              enabled: false,


              cursorColor: Colors.black,
              controller: locationController,
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 0),
                  width: 10,
                  height: 10,
                  child:
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                ),
                //   hintText: "pick up",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 12.0),
              ),
            ),

          ),
        ),
 ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child:
            IconButton(
                icon:  Icon(Icons.home_work),
                padding: const EdgeInsets.only( left: 350,top: 200.0),
                color:Colors.brown,
                iconSize:50,
                onPressed:(){
                  getLocation();
                  print("hello");

                }

            )
        ),


        ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child:
            IconButton(
                icon:  Icon(Icons.perm_device_info),
                padding: const EdgeInsets.only( top: 750.0),
                color:Colors.brown,
                iconSize:50,
                onPressed:(){
                  getLocation();
                  print("hello");

                }

            )
        ),

      ],

    ));
  }
  Future getCurrentLocation() async {
    LocationPermission permission = await GeolocationStatus.checkPermissionStatus();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await GeolocationStatus.requestPermission();
      if (permission != PermissionStatus.granted)
        getLocation();
      return;
    }
    getLocation();
  }
  List<Address> results = [];
  getLocation() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);



    setState(() {
      latlong=new LatLng(position.latitude, position.longitude);
      _cameraPosition=CameraPosition(target:latlong,zoom: 100.0 );
      if(_controller!=null)
        _controller.animateCamera(

            CameraUpdate.newCameraPosition(_cameraPosition));



      _markers.add(Marker(markerId: MarkerId("a"),draggable:true,position: latlong,icon: BitmapDescriptor.defaultMarkerWithHue(

          BitmapDescriptor.hueRed),onDragEnd: (_currentlatLng){
        latlong = _currentlatLng;

      }));
    });

    getCurrentAddress();
  }

  getCurrentAddress() async
  {

    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    results  = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    if(first!=null) {
      var address;
      address = first.featureName;
      address =   " $address, ${first.subLocality}" ;
      address =  " $address, ${first.subLocality}" ;
      address =  " $address, ${first.locality}" ;
      address =  " $address, ${first.countryName}" ;
      address = " $address, ${first.postalCode}" ;

      locationController.text = address;
    }
  }
}
*/
