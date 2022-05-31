import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverProvider {
  CollectionReference _ref;

  DriverProvider() {
    _ref = FirebaseFirestore.instance.collection('Drivers');
  }

  Future<void> create(Driver driver) {
    String errorMessage;

    try {
      //traemos el id donde se registra authentication de firebase
      return _ref.doc(driver.id).set(driver.toJson());
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  //solo trae la informacion una unica vez sin actualizaciones en tiempo real
  Future<Driver> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Driver driver = Driver.fromJson(document.data());
      return driver;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }
}
