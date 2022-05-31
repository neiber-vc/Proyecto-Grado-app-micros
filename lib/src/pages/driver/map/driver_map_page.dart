import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_micro_flutter/src/pages/driver/map/driver_map_controller.dart';
import 'package:app_micro_flutter/src/widgets/button_app.dart';

class DriverMapPage extends StatefulWidget {
  @override
  _DriverMapPageState createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  DriverMapController _con = new DriverMapController();

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  //metodo que se ejecuta cuando cerramos la pantalla
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('se ejecute el dispose');
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      drawer: _drawer(),
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonDrawer(),
                    _buttonCenterPosition(),
                  ],
                ),
                Expanded(child: Container()),
                _buttonConnect(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    _con.driver?.username ?? 'Nombre de usuario',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),
                Container(
                  child: Text(
                    _con.driver?.email ?? 'Correo Electronico',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundImage: _con.driver?.image != null
                      ? NetworkImage(_con.driver?.image)
                      : AssetImage(
                          'assets/img/profile.jpg',
                        ),
                  radius: 40,
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(
              Icons.edit,
              color: Colors.red,
            ),
            onTap: _con.goToEditPage,
          ),
          // ListTile(
          //   //selectedTileColor: Colors.red,
          //   title: Text('Historial'),
          //   trailing: Icon(
          //     Icons.timer,
          //     color: Colors.red,
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            //focusColor: Colors.red,
            title: Text('Cerrar Sesion'),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            onTap: _con.signOut,
          ),
        ],
      ),
    );
  }

  Widget _buttonCenterPosition() {
    return GestureDetector(
      onTap: _con.centerPosition,
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonDrawer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: _con.openDrawer,
        icon: Icon(
          Icons.menu,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
    );
  }

  Widget _buttonConnect() {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: ButtonApp(
        onPressed: _con.connect,
        text: _con.isConnect ? 'DESCONECTARSE' : 'CONECTARSE',
        color: _con.isConnect ? Colors.grey[300] : Colors.red,
        textColor: _con.isConnect ? Colors.red : Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
