import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:app_micro_flutter/src/models/travel_history.dart';
import 'package:app_micro_flutter/src/providers/driver_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelHistoryProvider {
  CollectionReference _ref;

  TravelHistoryProvider() {
    _ref = FirebaseFirestore.instance.collection('TravelHistory');
  }

  Future<String> create(TravelHistory travelHistory) async {
    String errorMessage;

    try {
      String id = _ref.doc().id;
      travelHistory.id = id;
      //traemos el id donde se registra authentication de firebase
      await _ref
          .doc(travelHistory.id)
          .set(travelHistory.toJson()); //almacenamos la informacion
      return id;
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<List<TravelHistory>> getByIdClient(String idClient) async {
    QuerySnapshot querySnapshot = await _ref
        .where('idClient', isEqualTo: idClient)
        .orderBy('timestamp', descending: true)
        .get(); //COnsulta para obtener de la coleccion travelHistory cuyo idCLient es igual al inicio de sesion del cliente
    List<Map<String, dynamic>> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    List<TravelHistory> travelHistoryList = new List();

    for (Map<String, dynamic> data in allData) {
      travelHistoryList.add(TravelHistory.fromJson(data));
    }

    for (TravelHistory travelHistory in travelHistoryList) {
      DriverProvider driverProvider = new DriverProvider();
      Driver driver = await driverProvider.getById(travelHistory.idDriver);
      travelHistory.plate = driver.plate;
      travelHistory.nameDriver = driver.username;
    }

    return travelHistoryList;
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<TravelHistory> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      TravelHistory travelHistory = TravelHistory.fromJson(document.data());
      return travelHistory;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }

  Future<void> delete(String id) {
    return _ref.doc(id).delete();
  }
}
