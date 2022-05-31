import 'package:app_micro_flutter/src/pages/client/map/client_map_controller.dart';
import 'package:app_micro_flutter/src/widgets/button_app.dart';
import 'package:app_micro_flutter/src/widgets/categor_icon.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ClientMapPage extends StatefulWidget {
  @override
  _ClientMapPageState createState() => _ClientMapPageState();
}

class _ClientMapPageState extends State<ClientMapPage> {
  ClientMapController _con = new ClientMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _con.timer.cancel();
    _con.customInfoWindowController.dispose();
    super.dispose();

    print('SE EJECUTO EL DISPOSE');
    _con.dispose();
  }

  // BorderRadiusGeometry radius = BorderRadius.only(
  //   topLeft: Radius.circular(24.0),
  //   topRight: Radius.circular(24.0),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      drawer: _drawer(),
      body: Stack(
        children: [
          _googleMapsWidget(),
          CustomInfoWindow(
            controller: _con.customInfoWindowController,
            height: 100,
            width: 250,
            offset: 40,
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 0,
            child: _cardInfoUser(),
          ),
          SizedBox(
            width: 10,
          ),
          SafeArea(
            child: Column(
              children: [
                _buttonDrawer(),
                SizedBox(height: 150),
                _buttonClear(),
                _buttonStyle(),
                _buttonCenterPosition(),
                Expanded(child: Container()),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          // aqui sliding
          _slidingData(),
        ],
      ),
    );
  }

  Widget cardInfoBus(
      String title, String horario, String salida, String retorno) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/img/bus1.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: CategoryIcon(
                        color: Colors.red,
                        iconName: title, //linea del micro
                        size: 15,
                        padding: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: RatingBar.builder(
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          itemSize: 30,
                          itemCount: 5,
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Text(
                        'HORARIO: $horario',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'Ruta de SALIDA: $salida',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'Ruta de RETORNO: $retorno',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'TARIFA DE PASAJE: 1.50 Bs',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.bus_alert,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardInfoUser() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.red,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage('assets/img/profile.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _con.client?.username ?? 'Nombre del Usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  _con?.from ?? 'Mi Localizacion',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        _con.client?.username ?? 'Nombre de usuario',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      child: Text(
                        _con.client?.email ?? 'Correo electronico',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundImage: _con.client?.image != null
                      ? NetworkImage(_con.client?.image)
                      : AssetImage(
                          'assets/img/profile.jpg',
                        ),
                  radius: 40,
                  //backgroundColor: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit),
            // leading: Icon(Icons.cancel),
            onTap: _con.goToEditPage,
          ),
          ListTile(
            title: Text('Historial'),
            trailing: Icon(Icons.timer),
            // leading: Icon(Icons.cancel),
            onTap: _con.goToHistoryPage,
          ),
          // ListTile(
          //   title: Text('Micros'),
          //   trailing: Icon(Icons.bus_alert),
          //   // leading: Icon(Icons.cancel),
          //   onTap: _con.goToMicros,
          // ),
          ListTile(
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
            // leading: Icon(Icons.cancel),
            onTap: _con.signOut,
          ),
          ListTile(
            title: Text(_con.user?.emailVerified == true
                ? "Correo Verificado"
                : "Correo No Verificado"),
            trailing: Icon(Icons.message),
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
        margin: EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
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

  Widget _buttonClear() {
    return GestureDetector(
      onTap: () {
        //_con.markers.clear();
        _con.polyline.clear();
        refresh();
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.cleaning_services_outlined,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonStyle() {
    return GestureDetector(
      onTap: () {
        //_con.dataCade();
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.layers,
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
          size: 30,
        ),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/userMap.png',
      width: 30,
      height: 30,
    );
  }

  Widget _buttonRequest() {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: ButtonApp(
        onPressed: _con.requestDriver,
        text: 'BUSCAR',
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      onTap: (position) {
        _con.customInfoWindowController.hideInfoWindow();
        this._con.pinPillPosition = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition2 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition3 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition4 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition5 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition6 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition7 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition8 = PIN_INVISIBLE_POSITION;
        this._con.pinPillPosition11 = PIN_INVISIBLE_POSITION;
        refresh();
      },
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
      polylines: _con.polyline,
      onCameraMove: (position) {
        _con.initialPosition = position;
        _con.customInfoWindowController.onCameraMove();
        print('ON CAMERA MOVE: $position');
      },
      onCameraIdle: () async {
        await _con.setLocationDraggabelInfo();
      },
    );
  }

  Widget _cardGooglePlaces() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoCardLocation('Desde', _con.from ?? 'Lugar de recogida',
                  () async {
                await _con.showGoogleAutoComplete(true);
              }),
              SizedBox(height: 5),
              Container(
                  // width: double.infinity,
                  child: Divider(color: Colors.grey, height: 10)),
              SizedBox(height: 5),
              _infoCardLocation('Hasta', _con.to ?? 'Lugar de destino',
                  () async {
                await _con.showGoogleAutoComplete(false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCardLocation(String title, String value, Function function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.start,
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _slidingData() {
    return SlidingUpPanel(
      renderPanelSheet: false,
      //panel: _floatingPanel(),
      collapsed: _floatingCollapsed(),
      panelBuilder: (ScrollController) => floatingPanel(),
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Center(
        child: Text(
          "Ruta del Micro",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget floatingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 10.0,
        //     color: Colors.red[50],
        //   ),
        // ],
      ),
      margin: const EdgeInsets.all(24.0),
      child: Center(
        child: _timeline(),
      ),
    );
  }

  Widget _timeline() {
    // return Column(
    //   children: _con.lista.map((value) => Text(value)).toList(),
    // );
    return ListView(
      shrinkWrap: true,
      //padding: const EdgeInsets.all(8),
      children: _con.lista.map((value) => Text(value)).toList(),
    );
    // return (
    //   child: Text(_con.lista()),
    //   // child: ListView(
    //   //   shrinkWrap: true,
    //   //   // children: <Widget>[
    //   //   //   // TimelineTile(
    //   //   //   //   alignment: TimelineAlign.manual,
    //   //   //   //   lineXY: 0.1,
    //   //   //   //   isFirst: true,
    //   //   //   //   indicatorStyle: const IndicatorStyle(
    //   //   //   //     width: 20,
    //   //   //   //     color: Color(0xFF27AA69),
    //   //   //   //     padding: EdgeInsets.all(7),
    //   //   //   //   ),
    //   //   //   //   endChild: _con.crearItems(),
    //   //   //   //   beforeLineStyle: const LineStyle(
    //   //   //   //     color: Color(0xFF27AA69),
    //   //   //   //   ),
    //   //   //   // ),
    //   //   // ],
    //   // ),
    // );
  }

  void refresh() {
    setState(() {});
  }
}
