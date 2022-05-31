import 'package:app_micro_flutter/src/models/travel_history.dart';
import 'package:app_micro_flutter/src/pages/client/history/client_history_controller.dart';
import 'package:app_micro_flutter/src/providers/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientHistoryPage extends StatefulWidget {
  ClientHistoryPage({Key key}) : super(key: key);

  @override
  _ClientHistoryPageState createState() => _ClientHistoryPageState();
}

class _ClientHistoryPageState extends State<ClientHistoryPage> {
  ClientHistoryController _con = ClientHistoryController();

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
      key: _con.key,
      appBar: AppBar(
        title: Text('Historial'),
      ),
      body: FutureBuilder(
        future: _con.getAll(),
        builder: (context, AsyncSnapshot<List<TravelHistory>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (_, index) {
                return _cardHistoryInfo(
                  snapshot.data[index].nameDriver,
                  snapshot.data[index].tarifa?.toString(),
                  snapshot.data[index].calificationClient?.toString(),
                  RelativeTimeUtil.getRelativeTime(
                      snapshot.data[index].timestamp ?? 0),
                  snapshot.data[index].id,
                );
              });
        },
      ),
    );
  }

  Widget _cardHistoryInfo(
    String name,
    String price,
    String calification,
    String timestamp,
    String idTravelHistory,
  ) {
    return GestureDetector(
      onTap: () {
        //_con.goToDetailHistory(idTravelHistory);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.red[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.bus_alert_outlined),
                SizedBox(width: 5),
                Text(
                  'Conductor: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.monetization_on),
                SizedBox(width: 5),
                Text(
                  'Precio: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    '$price \Bs' ?? '0\Bs',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.format_list_numbered),
                SizedBox(width: 5),
                Text(
                  'Calificacion: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    calification ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.timer),
                SizedBox(width: 5),
                Text(
                  'Hace: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    timestamp ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
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
