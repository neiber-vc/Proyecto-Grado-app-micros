import 'package:app_micro_flutter/src/pages/client/map_routes/map_routes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoutesPage extends StatefulWidget {
  MapRoutesPage({Key key}) : super(key: key);

  @override
  _MapRoutesPageState createState() => _MapRoutesPageState();
}

class _MapRoutesPageState extends State<MapRoutesPage> {
  MapRoutesController _con = MapRoutesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _con.key,
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonUserInfo(),
                    Column(
                      children: [
                        // _cardStatusInfo('_con.currentStatus'),
                        _cardStatusInfo('Line del Micro'),
                        // _cardMinInfo('0 min'),
                      ],
                    ),
                    _buttonCenterPosition(),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardStatusInfo(String status) {
    return SafeArea(
      child: Container(
        width: 110,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(right: 10, top: 35),
        decoration: BoxDecoration(
          color: _con.colorStatus,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          status ?? 'nada',
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buttonUserInfo() {
    return GestureDetector(
      onTap: _con.openBottomSheet,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCenterPosition() {
    return GestureDetector(
      onTap: () {},
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
              color: Colors.grey[600],
              size: 20,
            ),
          ),
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
      // polylines: _con.polylines,
    );
  }

  void refresh() {
    setState(() {});
  }
}
