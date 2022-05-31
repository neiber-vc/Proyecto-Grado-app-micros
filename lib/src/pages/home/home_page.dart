import 'package:app_micro_flutter/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = new HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.redAccent[700], Colors.red[50]])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _bannerApp(context),
                SizedBox(height: 50),
                _textSelectYourRol(),
                SizedBox(height: 30),
                _imageTypeUser(context, 'assets/img/user.png', 'client'),
                SizedBox(height: 10),
                _textTypeUser('Usuario'),
                SizedBox(height: 30),
                _imageTypeUser(context, 'assets/img/driver.png', 'driver'),
                SizedBox(height: 10),
                _textTypeUser('Conductor')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/img/autobus.png',
              width: 150,
              height: 100,
            ),
            Text(
              'Transporte Publico',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: utils.Colors.busColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textSelectYourRol() {
    return Text(
      'SELECCIONA TU INGRESO',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: 'OneDay',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _imageTypeUser(BuildContext context, String image, String typeUser) {
    return GestureDetector(
      onTap: () => _con.goToLoginPage(typeUser),
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 55,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _textTypeUser(String typeUser) {
    return Text(
      typeUser,
      style: TextStyle(
          color: Colors.redAccent[700],
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}
