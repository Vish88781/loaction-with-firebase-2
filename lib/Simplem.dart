/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  double co =0.0;
  double colong =0.0;

  void initState() {
    super.initState();

    initPlatfromState();
  }
  initPlatfromState()async{

    var prefs = await SharedPreferences.getInstance();

       co = prefs.getDouble('latitude');
      print("work 5");
      print(co);

    var rose = await SharedPreferences.getInstance();

     colong = rose.getDouble('longitude');
    print("work 6");
    print(colong);


  }
    Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(co,78.1638862),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.2050822,78.1638862),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the Postion!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
*/
import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class _MapState extends State<Map> {
   Completer<GoogleMapController> controller1;

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static  LatLng _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }
  var local;
  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
      local='${placemark[0].name}';
      print('working'+local);
    });
  }


  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
              infoWindow: InfoWindow(
                  title: "Pizza Parlour",
                  snippet: "This is a snippet",
                  onTap: (){
                  }
              ),
              onTap: (){
              },

              icon: BitmapDescriptor.defaultMarker));
    });
  }
  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
        _getUserLocation();
        print('i m pressed');
          },
      ),
*/
      body: _initialPosition == null ? Container(child: Center(child:Text('loading map..', style: TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),),),) : Container(
        child: Stack(children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,

            child: GoogleMap(
              markers: _markers,

              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 18.4746,

              ),
              onMapCreated: _onMapCreated,
              tiltGesturesEnabled: false,
              zoomGesturesEnabled: true,
              onCameraMove: _onCameraMove,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              padding:EdgeInsets.only(top:180,right: 10),
              buildingsEnabled: true,


            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.only(top:100),
                child: Column(
                  children: <Widget>[
                  /*  mapButton(_onAddMarkerButtonPressed,
                        Icon(
                            Icons.add_location
                        ), Colors.blue),
                    */mapButton(
                        _onMapTypeButtonPressed,
                        Icon(
                            Icons.home_work

                        ),
                        Colors.green),
                  ],
                )),
          )
        ]
        ),
      ),
    );
  }
}