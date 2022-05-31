import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_micro_flutter/src/pages/driver/edit/driver_edit_controller.dart';
import 'package:app_micro_flutter/src/utils/otp_widget.dart';
import 'package:app_micro_flutter/src/widgets/button_app.dart';
import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

class DriverEditPage extends StatefulWidget {
  DriverEditPage({Key key}) : super(key: key);

  @override
  _DriverEditPageState createState() => _DriverEditPageState();
}

class _DriverEditPageState extends State<DriverEditPage> {
  DriverEditController _con = new DriverEditController();

  @override
  void initState() {
    super.initState();
    print('INIT STATE');
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('METODO BUILD');
    return Scaffold(
      key: _con.key,
      appBar: AppBar(),
      bottomNavigationBar: _buttonRegister(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(),
            _textLogin(),
            _textLicencePlate(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: OTPFields(
                pin1: _con.pin1Controller,
                pin2: _con.pin2Controller,
                pin3: _con.pin3Controller,
                pin4: _con.pin4Controller,
                pin5: _con.pin5Controller,
                pin6: _con.pin6Controller,
              ),
            ),
            _textFieldUserName(),
            _textFieldLinea(),
          ],
        ),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.busColor,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _con.showAlertDialog,
              child: CircleAvatar(
                backgroundImage: _con.imageFile != null
                    ? FileImage(_con.imageFile)
                    : _con.driver?.image != null
                        ? NetworkImage(_con.driver?.image)
                        : AssetImage(
                            _con.imageFile?.path ?? 'assets/img/profile.jpg',
                          ),
                radius: 50,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                _con.driver?.email ?? '',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        'EDITAR PERFIL',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.usernameController,
        decoration: InputDecoration(
          hintText: 'Pepito Perez',
          labelText: 'Nombre de Usuario',
          suffixIcon: Icon(
            Icons.person_outline,
            color: utils.Colors.busColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldLinea() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.lineaController,
        decoration: InputDecoration(
            hintText: 'ejempl: 1',
            labelText: 'Linea del Micro',
            suffixIcon: Icon(
              Icons.bus_alert,
              color: utils.Colors.busColor,
            )),
      ),
    );
  }

  Widget _textLicencePlate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Placa del vehiculo',
        style: TextStyle(color: Colors.grey[600], fontSize: 17),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.update,
        text: 'Actualizar Ahora',
        color: utils.Colors.busColor,
        textColor: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
