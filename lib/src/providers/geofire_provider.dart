import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeofireProvider {
  CollectionReference _ref;
  Geoflutterfire _geo;

  GeofireProvider() {
    _ref = FirebaseFirestore.instance.collection('Locations');
    _geo = Geoflutterfire();
  }

  //para crear estados, posiciones del conductor en tiempo real con geoflutterfire
  Future<void> create(
      String id, double lat, double lng, String linea, String plate) {
    GeoFirePoint myLocation = _geo.point(latitude: lat, longitude: lng);
    return _ref.doc(id).set({
      'status': 'drivers_available',
      'position': myLocation.data,
      'linea': linea,
      'plate': plate
    });
  }

  Future<void> createWorkin(String id, double lat, double lng) {
    GeoFirePoint myLocation = _geo.point(latitude: lat, longitude: lng);
    return _ref
        .doc(id)
        .set({'status': 'drivers_working', 'position': myLocation.data});
  }

  Stream<DocumentSnapshot> getLocationByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<void> delete(String id) {
    return _ref.doc(id).delete();
  }

  //consulta para obtener todos lo conductores mas cercanos a mi posicion con radio dado
  Stream<List<DocumentSnapshot>> getNearbyDrivers(
      double lat, double lng, double radius) {
    GeoFirePoint center = _geo.point(latitude: lat, longitude: lng);
    return _geo
        .collection(
            collectionRef: _ref.where('status', isEqualTo: 'drivers_available'))
        .within(center: center, radius: radius, field: 'position');
  }
}
