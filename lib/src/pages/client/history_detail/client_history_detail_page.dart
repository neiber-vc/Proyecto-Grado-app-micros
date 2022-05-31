import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_micro_flutter/src/pages/client/history_detail/client_history_detail_controller.dart';
import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

class ClientHistoryDetailPage extends StatefulWidget {
  ClientHistoryDetailPage({Key key}) : super(key: key);

  @override
  _ClientHistoryDetailPageState createState() =>
      _ClientHistoryDetailPageState();
}

class _ClientHistoryDetailPageState extends State<ClientHistoryDetailPage> {
  ClientHistoryDetailController _con = new ClientHistoryDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del historial'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerInfoDriver(),
            _listTileInfo('Lugar de recogida', '_con.travelHistory?.from',
                Icons.location_on),
            _listTileInfo(
                'Destino', '_con.travelHistory?.to', Icons.location_searching),
            _listTileInfo(
                'Mi Calificacion',
                _con.travelHistory?.calificationClient?.toString(),
                Icons.star_border),
            _listTileInfo(
                'Calificacion del conductor',
                '_con.travelHistory?.calificationDriver?.toString()',
                Icons.star),
            _listTileInfo(
                'Precio del Viaje',
                '${'_con.travelHistory?.price?.toString()' ?? '0 \$'}',
                Icons.monetization_on_outlined),
          ],
        ),
      ),
    );
  }

  Widget _listTileInfo(String title, String value, IconData icon) {
    return ListTile(
      title: Text(title ?? ''),
      subtitle: Text(value ?? ''),
      leading: Icon(icon),
    );
  }

  Widget _bannerInfoDriver() {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        color: utils.Colors.busColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: _con.driver?.image != null
                  ? NetworkImage(_con.driver?.image)
                  : AssetImage(
                      'assets/img/profile.jpg',
                    ),
              radius: 40,
            ),
            SizedBox(height: 10),
            Text(
              _con.driver.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
