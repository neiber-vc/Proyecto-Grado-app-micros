import 'package:app_micro_flutter/src/models/expansion_model.dart';
import 'package:app_micro_flutter/src/pages/client/micros/client_micros_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientMicrosPage extends StatefulWidget {
  ClientMicrosPage({Key key}) : super(key: key);

  @override
  _ClientMicrosPageState createState() => _ClientMicrosPageState();
}

class _ClientMicrosPageState extends State<ClientMicrosPage> {
  ClientMicrosController _con = ClientMicrosController();

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
      appBar: AppBar(
        title: Text('Informacion de lineas'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(milliseconds: 1000),
              dividerColor: Colors.red,
              elevation: 1,
              children: [
                ExpansionPanel(
                  body: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // ClipOval(
                        //   child: CircleAvatar(
                        //     child: Image.asset(
                        //       itemData[index].img,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                itemData[index].discription,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 10,
                                    letterSpacing: 0.3,
                                    height: 1.3),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                itemData[index].discription2,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 10,
                                    letterSpacing: 0.3,
                                    height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        itemData[index].headerItem,
                        style: TextStyle(
                          color: itemData[index].colorsItem,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: itemData[index].expanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  itemData[index].expanded = !itemData[index].expanded;
                });
              },
            );
          },
        ),
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
        headerItem: 'Linea 1',
        discription:
            "SALIDA: \n HOSPITAL LAJASTAMBO \n AV. NAVARRA \n EX AEROPUERTO \n AV. JUAN AZURDUY \n PARADA RAVELO (PARADA MOMENTANEA) \n Z. TINTAMAYU \n AV. DEL MAESTRO \n AV. HERNANDO SILES (PARADA MOMENTANEA) \n CLL. ANICETO ARCE \n CLL. SAN ALBERTO \n Z. EL GUEREO \n AV. DEL EJERCITO \n Z. EL ABRA \n Z. RUMI RUMI \n Z. AZARI",
        discription2:
            "RETORNO: \n Z. AZARI \n Z. RUMI RUMI \n Z. EL ABRA \n AV. DEL EJERCITO \n AV. DEL EJERCITO \n Z. EL GUEREO \n CLL. CALVO \n CLL. ESPAÑA \n CLL. CAMARGO \n AV. HERNANDO SILES (PARADA MOMENTANEA) \n AV. DEL MAESTRO \n CLL. COBIJA \n AV. JUANA AZURDUY \n Z. TINTAMAYU \n PARADA RAVELO \n EX AEROPUERTO \n AV. NAVARRA \n HOSPITAL LASTAMBO",
        colorsItem: Colors.red,
        img: 'assets/img/uno.png'),
  ];

  void refresh() {
    setState(() {});
  }
}
