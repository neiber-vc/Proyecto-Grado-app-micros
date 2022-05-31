import 'package:app_micro_flutter/src/pages/client/edit/client_edit_page.dart';
import 'package:app_micro_flutter/src/pages/client/history/client_history_page.dart';
import 'package:app_micro_flutter/src/pages/client/history_detail/client_history_detail_page.dart';
import 'package:app_micro_flutter/src/pages/client/map/client_map_page.dart';
import 'package:app_micro_flutter/src/pages/client/micros/client_micros_page.dart';
import 'package:app_micro_flutter/src/pages/client/register/client_register_page.dart';
import 'package:app_micro_flutter/src/pages/driver/edit/driver_edit_page.dart';
import 'package:app_micro_flutter/src/pages/driver/map/driver_map_page.dart';
import 'package:app_micro_flutter/src/pages/driver/register/driver_register_page.dart';
import 'package:app_micro_flutter/src/pages/home/home_page.dart';
import 'package:app_micro_flutter/src/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

Future<void> _firebaseMessaginBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessaginBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'home',
      initialRoute: 'home',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        fontFamily: 'NimbusSans',
        appBarTheme: AppBarTheme(elevation: 0),
        primaryColor: utils.Colors.busColor,
        //primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: Colors.white,
      ),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'client/register': (BuildContext context) => ClientRegisterPage(),
        'driver/register': (BuildContext context) => DriverRegisterPage(),
        'client/map': (BuildContext context) => ClientMapPage(),
        'driver/map': (BuildContext context) => DriverMapPage(),
        'client/edit': (BuildContext context) => ClientEditPage(),
        'driver/edit': (BuildContext context) => DriverEditPage(),
        'client/history': (BuildContext context) => ClientHistoryPage(),
        'client/micros': (BuildContext context) => ClientMicrosPage(),
        'client/history/detail': (BuildContext context) =>
            ClientHistoryDetailPage(),
      },
    );
  }
}
