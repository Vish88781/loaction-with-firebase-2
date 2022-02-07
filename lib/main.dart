import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  bool exp = true;
  var h1;
 var h2;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  void op(lat) async{
    print('work 4 pagewwww');
    print(lat);
    var prefs = await SharedPreferences.getInstance();
    ///1m=0.000008983
    ///200m =0.00017966
    var a = 26.2051481;
    var b=26.188285;
     //  if (lat >a){


      print('walk15');
      home.add(({


        "count": _counter.toString(),
        "lat" : lat,

        "Time":timeString,
        "condtion":'if condition of onlocation'

      } ));

     /* setState(() {
        exp=false;
      });
*/



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
   /* var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
    IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
*/
    initPlatfromState();

    fence();
    gtime();
// if you move it give response
    bg.BackgroundGeolocation.onActivityChange((bg.ActivityChangeEvent event) {
      print('[onActivityChange] ${event}');
      users.add(({


        "count": _counter.toString(),
       "event":'${event}',
        "Time":timeString,
        //  "Time":timeString,

      } ));

    });



    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      double accuracy = location.coords.accuracy;
      double lat      = location.coords.latitude;
      double lng      = location.coords.longitude;
      double speed    = location.coords.speed;
      double heading  = location.coords.heading;
      double altitude = location.coords.altitude;


      print('[location] - $location');
      print('walk lat');
      print( lat);

      //workpage();


      users.add(({


           "count": _counter.toString(),
           "lat" : location.coords.latitude,
           "lng" : location.coords.longitude,

          "location":'[location] - $location',
        //  "Time":timeString,
        "Time":timeString,

      } ));
      op(lat);
      ot(lng);


    });
       print('come to walk 6');
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      print('on geo null walk14');

      print(event.action);
      print('rahul happy boy');
      print(timeString);
      if(event.action == "EXIT"){
        print('Exit Circle');
        rahul.add(({
          "Event": event.action,
          "Time": timeString,
        }));

        setState(() {
          exp=false;
        });
      }if(event.action=="ENTER"){
        rahul.add(({
          "Event": event.action,
          "Time": timeString,
        }));

        setState(() {
          exp=true;

        });

      }
      if(event.action=="DWELL"){
        rahul.add(({
          "Event": event.action,
          "Time": timeString,
        }));


      }

      print('walk11');
      users.add(({
        "Msg": 'onGeofence Run',
        "Time":timeString,

      } ));

      print('[geofence] ${event.identifier}, ${event.action}');
      h1= '${event.action}';
      print('walk6');
    });
    print('come to walk 7');



        // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
   /*   home.add(({
        "Msg": 'onMotionChange Run',
      } ));
*/
    });

    bg.BackgroundGeolocation.ready(bg.Config(
        heartbeatInterval: 60
    ));

    bg.BackgroundGeolocation.onHeartbeat((bg.HeartbeatEvent event) {
      gtime();
      print(timeString);
      beat.add(({

        "Beat": "beat",
        "Time":timeString,
      } ));

      print('[onHeartbeat--shekhawat] ${event}');
      print(timeString);
      bg.BackgroundGeolocation.startGeofences();

      // You could request a new location if you wish.
      bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1,
          persist: true
      ).then((bg.Location location) {
        print('[getCurrentPosition] ${location}');
      });
    });

//comment start
/*
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      print('[geofence] ${event.identifier}, ${event.action}');
      print(' Shekhawat\n[geofence] ${event.identifier}, ${event.action}');



    });
*/

    /*bg.BackgroundGeolocation.onGeofencesChange((bg.GeofencesChangeEvent event) {
      // Create map circles

      event.on.forEach((bg.Geofence geofence) {
        createGeofenceMarker(geofence);
      });

      // Remove map circles
      event.off.forEach((String identifier) {
        removeGeofenceMarker(identifier);
      });
          });
*/
    //comment  end
    bg.BackgroundGeolocation.addGeofence(bg.Geofence(
        identifier: "Home",
        radius: 150,
        latitude: 26.2051108,
        longitude: 78.1639269,
        notifyOnEntry: true,
        notifyOnExit: true,
        notifyOnDwell: true,
        loiteringDelay: 30000,  // 30 seconds
       )).then((bool success) {
    /*  scheduleNotification("You moved significantly",
          "a significant location change just happened.");
*/
      print('[addGeofence] success walk 8');
    /*    home.add(({
        "Msg": 'addGeofence Run',
          "Time":timeString,
      } ));
    */  var a = 26.2051481;
      var b=26.188285;
      //  if (lat >a){
        print('walk15');
        home.add(({
          "count": _counter.toString(),
          "Time": timeString,
          "condtion": 'if condition of addgeofence'
        }));


        print(success);
       });



    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');

      home.add(({

        "msg": "provideChange RUn",
        "Time":timeString,
      } ));

    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        foregroundService: true,

        debug: false,
        heartbeatInterval: 60,
        forceReloadOnGeofence: true,
        forceReloadOnBoot: true,
        forceReloadOnHeartbeat: true,

        //schedule:, this plugin is used for stop tracking and you can set the time
        autoSync: true,
        geofenceModeHighAccuracy: true,
        locationAuthorizationRequest:'Always',

        reset: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,

      // <-- consumes more power; default is false.

      )).then((bg.State state) {
      bg.BackgroundGeolocation.startGeofences();

      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
     //   bg.BackgroundGeolocation.start();
        bg.BackgroundGeolocation.startGeofences();

      }
    });

    ///stop tracking only apply when config.schduel is set comment start
    bg.BackgroundGeolocation.onSchedule((bg.State state) {
      if (state.enabled) {
        print('[onSchedule] scheduled start tracking');
      } else {
        print('[onSchedule] scheduled stop tracking');
      }
    });

    ///SEEE LATER
  /*  bg.BackgroundGeolocation.setConfig(bg.Config(
        locationAuthorizationRequest: "Any",
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      print("Changed logLevel success");
      bg.BackgroundGeolocation.startGeofences();

    });*/
//comment end





  }
 var timeString;
  var  users;
  var home;
  var rahul;
  var beat;
  initPlatfromState()async{
    users = FirebaseFirestore.instance.collection('users');
    home  = FirebaseFirestore.instance.collection('op');
    rahul = FirebaseFirestore.instance.collection('Rahul');
    beat = FirebaseFirestore.instance.collection('beat');





  }
  void fence()async{
    List<bg.Geofence> geofences = await bg.BackgroundGeolocation.geofences;
    print('walk12');
    print('[getGeofences: $geofences');

  }
  void workpage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Map()),
    );

  }
  void gtime() {
    String formattedDateTime =
    //  DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    DateFormat('yyyy-MM-dd \n kk:mm').format(DateTime.now()).toString();
    timeString = formattedDateTime;
    print(timeString+'walk 9');
  }

  void _incrementCounter() async {

    //insert start
    setState(() {
      _counter++;
    });
    users.add(({

      "count": _counter.toString(),
      "name": "acer"+_counter.toString(),
      "Time":timeString,


    } ));

// insert end comment start

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

//eget all dta end hrer comment end













  }


 void geoEvent(){
   home.add(({

     "count": _counter.toString(),
     "Time":timeString,

     "Msg":'Walk6 from geoEvent Function' ,

   } ));


 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      /*show?LinearProgressIndicator(
      ):
      */Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status',
            ),
           exp?Text('You are In geofence'):Text('You are out geofence'),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:()async{
       //   geoEvent();
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
  /*void scheduleNotification(String title, String subtitle) {
    print("scheduling one with $title and $subtitle");
    var rng = new Random();
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          rng.nextInt(100000), title, subtitle, platformChannelSpecifics,
          payload: 'item x');
    });
  }
*/
}