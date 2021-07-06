import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:withfirea/Maps.dart';

import 'Simplem.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  State createState() {
    // TODO: implement createState
    return _MyHomePageState ();
  }

  final String title;


}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool show = true;

  void op(lat) async{
    print('work 4 pagewwww');
    print(lat);
    var prefs = await SharedPreferences.getInstance();

    prefs.setDouble('latitude', lat);//(key:data)
  }

  void ot(lng) async{
    print('work 5 pagewwwwwww');
    print(lng);
    var rose = await SharedPreferences.getInstance();

    rose.setDouble('longitude', lng);//(key:data)
  }


  void initState() {
    super.initState();
    initPlatfromState();
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      double accuracy = location.coords.accuracy;
      double lat      = location.coords.latitude;
      double lng      = location.coords.longitude;
      double speed    = location.coords.speed;
      double heading  = location.coords.heading;
      double altitude = location.coords.altitude;

      print('[location] - $location');
      workpage();


      users.add(({


           "count": _counter.toString(),
           "lat" : location.coords.latitude,
           "lng" : location.coords.longitude,

          "location":'[location] - $location'
      } ));

      op(lat);
      ot(lng);


      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MapSample(lat,lng)),

      );
*/

    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: true,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });




  }

  var  users;
  initPlatfromState()async{
    users = FirebaseFirestore.instance.collection('users');
  }
  void workpage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Map()),
    );

  }

  void _incrementCounter() async {

    //insert start
    setState(() {
      _counter++;
    });
    users.add(({

      "count": _counter.toString(),
      "name": "acer"+_counter.toString()

    } ));

// insert end

    //   select star
    /*      var usersFromFirebase=await users.where("count", isEqualTo: "1").get();
          {
            print(usersFromFirebase.docs[0]["name"].toString());
          }
        */  //select end

    //up start
    /*    var usersFromFirebase=await users.where("count", isEqualTo: "1").get();

          print(usersFromFirebase.docs[0].id);

          users.doc(usersFromFirebase.docs[0].id).update({
            "name":"Player"
          });
*/
//up end

    // del start
/*    var usersFromFirebase=await users.where("count", isEqualTo: "1").get();

    print(usersFromFirebase.docs[0].id);

    users.doc(usersFromFirebase.docs[0].id).delete();*/

    //del end

    // get all and delete
/*

    var userFromFirebase= await users.get();
    userFromFirebase.docs.forEach((doc){
      print(doc["name"]);
      users.doc(doc.id).delete();
    });
*/

//eget all dta end hrer













  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: show?LinearProgressIndicator(
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:()async{
          var prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
          var co = prefs.getDouble('latitude') ?? 'Something went wrong';
          print('vsis');
          print(co);

          _incrementCounter();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>Map()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}