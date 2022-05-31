import 'dart:async';

import 'package:app_micro_flutter/src/api/environment.dart';
import 'package:app_micro_flutter/src/models/client.dart';
import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:app_micro_flutter/src/models/travel_history.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_1.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_11.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_11v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_1v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_2.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_2v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_3.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_3v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_4.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_4v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_5.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_5v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_6.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_6v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_7.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_7v.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_8.dart';
import 'package:app_micro_flutter/src/pages/lineas_micros/linea_8v.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/client_provider.dart';
import 'package:app_micro_flutter/src/providers/driver_provider.dart';
import 'package:app_micro_flutter/src/providers/geofire_provider.dart';
import 'package:app_micro_flutter/src/providers/travel_history_provider.dart';
import 'package:app_micro_flutter/src/utils/my_progress_dialog.dart';
import 'package:app_micro_flutter/src/widgets/categor_icon.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:app_micro_flutter/src/utils/snackbar.dart' as utils;
import 'package:location/location.dart' as location;
import 'package:google_maps_webservice/places.dart' as places;
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:timeline_tile/timeline_tile.dart';

const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class ClientMapController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();

  double pinPillPosition = PIN_INVISIBLE_POSITION;
  double pinPillPosition2 = PIN_INVISIBLE_POSITION;
  double pinPillPosition3 = PIN_INVISIBLE_POSITION;
  double pinPillPosition4 = PIN_INVISIBLE_POSITION;
  double pinPillPosition5 = PIN_INVISIBLE_POSITION;
  double pinPillPosition6 = PIN_INVISIBLE_POSITION;
  double pinPillPosition7 = PIN_INVISIBLE_POSITION;
  double pinPillPosition8 = PIN_INVISIBLE_POSITION;
  double pinPillPosition9 = PIN_INVISIBLE_POSITION;
  double pinPillPosition10 = PIN_INVISIBLE_POSITION;
  double pinPillPosition11 = PIN_INVISIBLE_POSITION;

  CameraPosition initialPosition =
      CameraPosition(target: LatLng(-19.0353, -65.2592), zoom: 14.0);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Marker> markersMic = {};

  Set<Polyline> polyline = new Set();
  Set<Polyline> polyline2 = new Set();
  bool mostrar = false;

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  //geojson
  final lines = <Polyline>[];
  //polyline
  //PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  Position _position;
  StreamSubscription<Position> _positionStream;

  BitmapDescriptor markerDriver;

  GeofireProvider _geofireProvider;
  AuthProvider _authProvider;
  DriverProvider _driverProvider;
  ClientProvider _clientProvider;
  TravelHistoryProvider _travelHistoryProvider;

  bool isConnect = false;
  ProgressDialog _progressDialog;

  StreamSubscription<DocumentSnapshot> _statusSuscription;
  StreamSubscription<DocumentSnapshot> _clientInfoSubscription;
  StreamSubscription<DocumentSnapshot> _driverInfoSuscription;

  Client client;
  Driver driver;

  String _idTravel;

  String from;
  LatLng fromLatLng;

  String to;
  LatLng toLatLng;

  bool isFromSelected = true;
  PolylinePoints polylinePoints = PolylinePoints();

  bool mapStyleDark = false;
  double calification;

  //User emailVerify;
  //User userVerified;

  List<List<double>> listadb = [];
  List<String> lista = [];

  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Environment.API_KEY_MAPS);

  CustomInfoWindowController customInfoWindowController =
      new CustomInfoWindowController();

  bool flag;
  User user;
  Timer timer;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _geofireProvider = new GeofireProvider();
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();
    _clientProvider = new ClientProvider();
    _travelHistoryProvider = new TravelHistoryProvider();
    // _idTravel = ModalRoute.of(context).settings.arguments as String;
    //customInfoWindowController = new CustomInfoWindowController();

    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Conectandose...');
    markerDriver =
        await createMarkerImageFromAsset('assets/img/location_pin.png');

    checkGPS();
    getClientInfo();
    getDriverInfo();
    setSourceAndDestinationIcons();
    //getData();
    //refresh();
    //saveTravelHistory(1.5);
    //getDataPlate();
    //();
    //print('puntos:${listadb.length}');
    //print(listadb);
    //print("Correo esta verificado: $userVerified");
    //dataCade();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
      refresh();
    });
  }

  void rutaLinea1() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "1") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point4 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point4.add(latLang);
    }
    print('puntos:$point4');

    List<LatLng> distPoints2 = point4;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  // Future<bool> get userVerified async {
  //   await _authProvider.getUser().reload();
  //   return _authProvider.getUser().emailVerified;
  // }

  //verificacion del email
  Future<void> checkEmailVerified() async {
    user = _authProvider.getUser();
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      print("verificacion: $user");
      print("Se verifico el correo");
    } else {
      print("Verifique su correo por favor");
      print("verificacion: ${user?.emailVerified}");
      //user.emailVerified = noVery.toString();
    }
  }

  getData() async {
    User isUserEmailVerified = _authProvider.getUser();
    await isUserEmailVerified.reload();
    //isUserEmailVerified = _authProvider.getUser();
    //refresh();
    flag = isUserEmailVerified.emailVerified;
    // bool verificacion = _authProvider.getUser().emailVerified;
    //print('CORREO VERIFICADO: ${emailVerify.emailVerified}');
  }

  void goToMicros() {
    Navigator.pushNamed(context, 'client/micros');
  }

  void goToHistoryPage() {
    Navigator.pushNamed(context, 'client/history');
  }

  //informacion del conductor
  void getDriverInfo() {
    Stream<DocumentSnapshot> driverStream =
        _driverProvider.getByIdStream(_authProvider.getUser().uid);
    _driverInfoSuscription = driverStream.listen((DocumentSnapshot document) {
      //listen para escuchar los cambios en tiempo real
      driver = Driver.fromJson(document.data());
      //obtenemos toda la informacion en driver
      refresh();
    });
  }

  void getClientInfo() {
    Stream<DocumentSnapshot> clientStream =
        _clientProvider.getByIdStream(_authProvider.getUser().uid);
    _clientInfoSubscription = clientStream.listen((DocumentSnapshot document) {
      client = Client.fromJson(document.data());
      //getData(); //obtenemos toda la informacion en driver
      refresh();
    });
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void dispose() {
    _positionStream?.cancel();
    _statusSuscription?.cancel();
    _clientInfoSubscription?.cancel();
  }

  void signOut() async {
    await _authProvider.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
  }

  void onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    _mapController.complete(controller);

    // controller.setMapStyle(
    //     '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    // _mapController.complete(controller);
    customInfoWindowController.googleMapController = controller;
  }

  //metodo para actualizacion en tiempo real de mi ubicacion
  void updateLocation() async {
    try {
      await _determinePosition(); //busca la posicion del conductor
      _position = await Geolocator.getLastKnownPosition(); //UNA VEZ

      centerPosition();
      getNearbyDrivers();
    } catch (error) {
      print('Error en la localizacion: $error');
    }
  }

  void requestDriver() {
    if (fromLatLng != null && toLatLng != null) {
      Navigator.pushNamed(context, 'client/travel/info', arguments: {
        'from': from,
        'to': to,
        'fromLatLng': fromLatLng,
        'toLatLng': toLatLng,
      });
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Seleccionar el lugar de recogida y destino');
    }
  }

  void changeFromTo() {
    isFromSelected = !isFromSelected;
    if (isFromSelected) {
      utils.Snackbar.showSnackbar(
          context, key, 'Estas seleccionando el lugar de recogida');
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Estas seleccionando el destino');
    }
  }

  Future<Null> showGoogleAutoComplete(bool isFrom) async {
    places.Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Environment.API_KEY_MAPS,
      language: 'es',
      strictbounds: true,
      radius: 5000,
      location: places.Location(-19.047911, -65.259846),
    );

    if (p != null) {
      places.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId, language: 'es');
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      List<Address> address =
          await Geocoder.local.findAddressesFromQuery(p.description);
      if (address != null) {
        if (address.length > 0) {
          if (detail != null) {
            String direction = detail.result.name;
            String city = address[0].locality;
            String departament = address[0].adminArea;

            if (isFrom) {
              from = '$direction, $city, $departament';
              fromLatLng = new LatLng(lat, lng);
            } else {
              to = '$direction, $city, $departament';
              toLatLng = new LatLng(lat, lng);
            }

            refresh();
          }
        }
      }
    }
  }

  void goToEditPage() {
    Navigator.pushNamed(context, 'client/edit');
  }

  Future<Null> setLocationDraggabelInfo() async {
    if (initialPosition != null) {
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;
      List<Placemark> address = await placemarkFromCoordinates(lat, lng);

      if (address != null) {
        if (address.length > 0) {
          String direction = address[0].thoroughfare;
          String street = address[0].thoroughfare;
          String city = address[0].locality;
          String departament = address[0].administrativeArea;
          String country = address[0].country;
          String name = address[0].name;

          if (isFromSelected) {
            //from = '$direction #$street, $city, $departament';
            from = '$direction #$name';
            fromLatLng = new LatLng(lat, lng);
          } else {
            to = '$direction #$street, $city, $departament';
            toLatLng = new LatLng(lat, lng);
          }

          print('FROM: $from');

          refresh();
        }
      }
    }
  }

  void getNearbyDrivers() {
    Stream<List<DocumentSnapshot>> stream = _geofireProvider.getNearbyDrivers(
        _position.latitude, _position.longitude, 10);
    stream.listen((List<DocumentSnapshot> documentList) {
      for (MarkerId m in markers.keys) {
        bool remove = true;

        for (DocumentSnapshot d in documentList) {
          if (m.value == d.id) {
            remove = false;
          }
        }

        if (remove) {
          markers.remove(m);
          refresh();
        }
      }
      //String linea = d.data()['linea'];
      for (DocumentSnapshot d in documentList) {
        GeoPoint point = d.data()['position']['geopoint'];
        String linea = d.data()['linea'];
        String plate = d.data()['plate'];
        print('LINEAS: $linea');
        addMarker(
          d.id,
          point.latitude,
          point.longitude,
          // 'Conductor: ${linea.characters}',
          '$linea',
          '$plate',
          markerDriver,
        );
      }
      refresh();
    });
  }

  //para centrar la camara donde estemos ubicado
  void centerPosition() {
    if (_position != null) {
      animateCameraToPosition(_position.latitude, _position.longitude);
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Activa el GPS para obtener la posicion');
    }
  }

  //validacion para que el usuario active su gps
  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      print('GPS ACTIVADO');
      updateLocation();
    } else {
      print('GPS DESACTIVADO');
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();

        print('ACTIVO EL GPS');
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(latitude, longitude),
            zoom: 14,
          ),
        ),
      );
    }
  }

  //Metodo para transformar una imagen simple a un marcador
  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    //MarkerId titleId = MarkerId(title);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        //infoWindow: InfoWindow(title: title, snippet: content),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        rotation: _position.heading,
        onTap: () {
          // this.pinPillPosition = PIN_VISIBLE_POSITION;
          // refresh();
          this.customInfoWindowController.addInfoWindow(
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.all(20),
                        //padding: EdgeInsets.all(5),
                        // height: 500,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                    image: AssetImage('assets/img/bus.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                // child: Icon(
                                //   Icons.bus_alert_outlined,
                                //   color: Colors.white,
                                //   size: 25,
                                // ),
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Linea Nro: $title',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Center(
                                      child: RatingBar.builder(
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                        itemSize: 20,
                                        itemCount: 5,
                                        initialRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        onRatingUpdate: (rating) {
                                          calification = rating;
                                          print(rating);
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Container(
                                          height: 20,
                                          width: 60,
                                          child: FlatButton(
                                            //height: 25,
                                            onPressed: () {
                                              polyline.clear();

                                              optionsSHow(title);

                                              refresh();
                                            },
                                            child: Text(
                                              'Ruta',
                                              style: TextStyle(
                                                height: 0.6,
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                            ),
                                            color: Colors.white,
                                            //textColor: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 20,
                                          width: 60,
                                          child: FlatButton(
                                            //height: 25,
                                            onPressed: () {
                                              polyline.clear();

                                              saveTravelHistory(1.5, markerId,
                                                  calification, content);
                                              utils.Snackbar.showSnackbar(
                                                  context,
                                                  key,
                                                  'Calificacion exitosa');

                                              refresh();
                                            },
                                            child: Text(
                                              'valorar',
                                              style: TextStyle(
                                                height: 0.5,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                            color: Colors.white,
                                            textColor: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Triangle.isosceles(
                      edge: Edge.BOTTOM,
                      child: Container(
                        color: Colors.red,
                        width: 30.0,
                        height: 20.0,
                      ),
                    ),
                  ],
                ),
                LatLng(lat, lng),
              );
        });

    markers[id] = marker;
    //setMapPins();
    refresh();
  }

  void rutaCrear() {
    // List<LatLng> distPoints = addPoints();
    // List<Polyline> distPolyline = [
    //   Polyline(
    //     polylineId: PolylineId('Linea01'),
    //     points: distPoints,
    //     color: Colors.red,
    //     width: 3,
    //     //visible: mostrar,
    //     //fillColor: Color(0xFFFF1744).withOpacity(0.4),
    //   ),
    // ];

    // polyline.addAll(distPolyline);
    addSimpleMarker();
    addSimpleMarker2();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear2() {
    List<LatLng> distPoints2 = addPoints2();
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void desicion() {
    if (polyline != null) {
      polyline = polyline2;
    }
  }

  void addSimpleMarker() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea1Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker2() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea1Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  void optionsSHow(String title) {
    print('Linea $title');
    switch (title) {
      case '1':
        //rutaCrear();
        rutaLinea1();
        mostrarMic1();
        //rutaCrear2();
        //cardInfoBus(title);
        this.pinPillPosition = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '2':
        //rutaCrear3();
        rutaLinea2();
        mostrarMic2();
        this.pinPillPosition2 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '3':
        //rutaCrear5();
        rutaLinea3();
        mostrarMic3();
        this.pinPillPosition3 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '4':
        //rutaCrear7();
        rutaLinea4();
        mostrarMic4();
        this.pinPillPosition4 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '5':
        //rutaCrear9();
        //rutaCrear10();
        rutaLinea5();
        mostrarMic5();
        this.pinPillPosition5 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '6':
        // rutaCrear11();
        // rutaCrear12();
        rutaLinea6();
        mostrarMic6();
        this.pinPillPosition6 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '7':
        // rutaCrear13();
        // rutaCrear14();
        rutaLinea7();
        mostrarMic7();
        this.pinPillPosition7 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '8':
        // rutaCrear15();
        // rutaCrear16();
        rutaLinea8();
        mostrarMic8();
        this.pinPillPosition8 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '9':
        rutaLinea9();
        mostrarMic9();
        this.pinPillPosition9 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '10':
        rutaLinea10();
        mostrarMic10();
        this.pinPillPosition10 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      case '11':
        // rutaCrear17();
        // rutaCrear18();
        rutaLinea11();
        mostrarMic11();
        this.pinPillPosition11 = PIN_VISIBLE_POSITION;
        refresh();
        break;
      default:
        print('No tiene Ruta');
        utils.Snackbar.showSnackbar(context, key, 'No tiene Ruta');
    }
    // rutaCrear();
    // rutaCrear2();
    // setSourceAndDestinationIcons();
    //refresh();
    //}

    //setMapPins();

    //} else {}
  }

  void optionsSHow2(bool mostrar) {
    if (mostrar == true) {
      rutaCrear2();
      //setSourceAndDestinationIcons();
      //setMapPins();
      refresh();
    } else {}
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/img/map_pin_blue.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/img/map_pin_red.png');
  }

  addPoints() {
    List<LatLng> point = [];
    for (var i = 0; i < Linea1Ida.IN.length; i++) {
      var latLang = LatLng(Linea1Ida.IN[i][1], Linea1Ida.IN[i][0]);
      point.add(latLang);
    }
    return point;
  }

  addPoints2() {
    List<LatLng> point2 = [];
    for (var i = 0; i < Linea1Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea1Vuelta.IN[i][1], Linea1Vuelta.IN[i][0]);
      point2.add(latLang);
    }
    return point2;
  }

  //////////////////////////////////////////////////
  addPoints3() {
    List<LatLng> point3 = [];
    for (var i = 0; i < Linea2Ida.IN.length; i++) {
      var latLang = LatLng(Linea2Ida.IN[i][1], Linea2Ida.IN[i][0]);
      point3.add(latLang);
    }
    return point3;
  }

  addPoints4() {
    List<LatLng> point4 = [];
    for (var i = 0; i < Linea2Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea2Vuelta.IN[i][1], Linea2Vuelta.IN[i][0]);
      point4.add(latLang);
    }
    return point4;
  }

  void rutaCrear3() {
    // List<LatLng> distPoints3 = addPoints3();
    // List<Polyline> distPolyline3 = [
    //   Polyline(
    //     polylineId: PolylineId('Linea2'),
    //     points: distPoints3,
    //     color: Colors.red,
    //     width: 3,
    //     //visible: mostrar,
    //     //fillColor: Color(0xFFFF1744).withOpacity(0.4),
    //   ),
    // ];

    // polyline.addAll(distPolyline3);
    addSimpleMarker3();
    addSimpleMarker4();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear4() {
    List<LatLng> distPoints4 = addPoints4();
    List<Polyline> distPolyline4 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints4,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline4);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker3() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea2Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker4() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea2Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 3
  addPoints5() {
    List<LatLng> point3 = [];
    for (var i = 0; i < Linea3Ida.IN.length; i++) {
      var latLang = LatLng(Linea3Ida.IN[i][1], Linea3Ida.IN[i][0]);
      point3.add(latLang);
    }
    return point3;
  }

  addPoints6() {
    List<LatLng> point4 = [];
    for (var i = 0; i < Linea3Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea3Vuelta.IN[i][1], Linea3Vuelta.IN[i][0]);
      point4.add(latLang);
    }
    return point4;
  }

  void rutaCrear5() {
    // List<LatLng> distPoints5 = addPoints5();
    // List<Polyline> distPolyline5 = [
    //   Polyline(
    //     polylineId: PolylineId('Linea2'),
    //     points: distPoints5,
    //     color: Colors.red,
    //     width: 3,
    //     //visible: mostrar,
    //     //fillColor: Color(0xFFFF1744).withOpacity(0.4),
    //   ),
    // ];

    // polyline.addAll(distPolyline5);
    addSimpleMarker5();
    addSimpleMarker6();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear6() {
    List<LatLng> distPoints6 = addPoints6();
    List<Polyline> distPolyline6 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints6,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline6);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker5() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea3Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker6() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea3Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 4---------------------------------------------------------------------------------------
  addPoints7() {
    List<LatLng> point7 = [];
    for (var i = 0; i < Linea4Ida.IN.length; i++) {
      var latLang = LatLng(Linea4Ida.IN[i][1], Linea4Ida.IN[i][0]);
      point7.add(latLang);
    }
    return point7;
  }

  addPoints8() {
    List<LatLng> point8 = [];
    for (var i = 0; i < Linea4Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea4Vuelta.IN[i][1], Linea4Vuelta.IN[i][0]);
      point8.add(latLang);
    }
    return point8;
  }

  void rutaCrear7() {
    List<LatLng> distPoints7 = addPoints7();
    List<Polyline> distPolyline7 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints7,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline7);
    addSimpleMarker7();
    addSimpleMarker8();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear8() {
    List<LatLng> distPoints8 = addPoints8();
    List<Polyline> distPolyline8 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints8,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline8);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker7() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea4Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker8() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea4Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 5---------------------------------------------------------------------------------------
  addPoints9() {
    List<LatLng> point9 = [];
    for (var i = 0; i < Linea5Ida.IN.length; i++) {
      var latLang = LatLng(Linea5Ida.IN[i][1], Linea5Ida.IN[i][0]);
      point9.add(latLang);
    }
    return point9;
  }

  addPoints10() {
    List<LatLng> point10 = [];
    for (var i = 0; i < Linea5Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea5Vuelta.IN[i][1], Linea5Vuelta.IN[i][0]);
      point10.add(latLang);
    }
    return point10;
  }

  void rutaCrear9() {
    List<LatLng> distPoints9 = addPoints9();
    List<Polyline> distPolyline9 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints9,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline9);
    addSimpleMarker9();
    addSimpleMarker10();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear10() {
    List<LatLng> distPoints10 = addPoints10();
    List<Polyline> distPolyline10 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints10,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline10);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker9() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea5Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker10() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea5Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 6---------------------------------------------------------------------------------------
  addPoints11() {
    List<LatLng> point11 = [];
    for (var i = 0; i < Linea6Ida.IN.length; i++) {
      var latLang = LatLng(Linea6Ida.IN[i][1], Linea6Ida.IN[i][0]);
      point11.add(latLang);
    }
    return point11;
  }

  addPoints12() {
    List<LatLng> point12 = [];
    for (var i = 0; i < Linea6Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea6Vuelta.IN[i][1], Linea6Vuelta.IN[i][0]);
      point12.add(latLang);
    }
    return point12;
  }

  void rutaCrear11() {
    List<LatLng> distPoints11 = addPoints11();
    List<Polyline> distPolyline11 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints11,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline11);
    addSimpleMarker11();
    addSimpleMarker12();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear12() {
    List<LatLng> distPoints12 = addPoints12();
    List<Polyline> distPolyline12 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints12,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline12);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker11() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea6Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker12() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea6Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 7---------------------------------------------------------------------------------------
  addPoints13() {
    List<LatLng> point13 = [];
    for (var i = 0; i < Linea7Ida.IN.length; i++) {
      var latLang = LatLng(Linea7Ida.IN[i][1], Linea7Ida.IN[i][0]);
      point13.add(latLang);
    }
    return point13;
  }

  addPoints14() {
    List<LatLng> point14 = [];
    for (var i = 0; i < Linea7Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea7Vuelta.IN[i][1], Linea7Vuelta.IN[i][0]);
      point14.add(latLang);
    }
    return point14;
  }

  void rutaCrear13() {
    List<LatLng> distPoints13 = addPoints13();
    List<Polyline> distPolyline13 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints13,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline13);
    addSimpleMarker13();
    addSimpleMarker14();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear14() {
    List<LatLng> distPoints14 = addPoints14();
    List<Polyline> distPolyline14 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints14,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline14);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker13() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea7Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker14() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea7Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 8---------------------------------------------------------------------------------------
  addPoints15() {
    List<LatLng> point15 = [];
    for (var i = 0; i < Linea8Ida.IN.length; i++) {
      var latLang = LatLng(Linea8Ida.IN[i][1], Linea8Ida.IN[i][0]);
      point15.add(latLang);
    }
    return point15;
  }

  addPoints16() {
    List<LatLng> point16 = [];
    for (var i = 0; i < Linea8Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea8Vuelta.IN[i][1], Linea8Vuelta.IN[i][0]);
      point16.add(latLang);
    }
    return point16;
  }

  void rutaCrear15() {
    List<LatLng> distPoints15 = addPoints15();
    List<Polyline> distPolyline15 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints15,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline15);
    addSimpleMarker15();
    addSimpleMarker16();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear16() {
    List<LatLng> distPoints16 = addPoints16();
    List<Polyline> distPolyline16 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints16,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline16);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker15() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea8Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker16() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea8Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  ////LINEA 11---------------------------------------------------------------------------------------
  addPoints17() {
    List<LatLng> point17 = [];
    for (var i = 0; i < Linea11Ida.IN.length; i++) {
      var latLang = LatLng(Linea11Ida.IN[i][1], Linea11Ida.IN[i][0]);
      point17.add(latLang);
    }
    return point17;
  }

  addPoints18() {
    List<LatLng> point18 = [];
    for (var i = 0; i < Linea11Vuelta.IN.length; i++) {
      var latLang = LatLng(Linea11Vuelta.IN[i][1], Linea11Vuelta.IN[i][0]);
      point18.add(latLang);
    }
    return point18;
  }

  void rutaCrear17() {
    List<LatLng> distPoints17 = addPoints17();
    List<Polyline> distPolyline17 = [
      Polyline(
        polylineId: PolylineId('Linea2'),
        points: distPoints17,
        color: Colors.red,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline17);
    addSimpleMarker17();
    addSimpleMarker18();
    //setSourceAndDestinationIcons();
  }

  void rutaCrear18() {
    List<LatLng> distPoints18 = addPoints18();
    List<Polyline> distPolyline18 = [
      Polyline(
        polylineId: PolylineId('Linea2v'),
        points: distPoints18,
        color: Colors.blue[700],
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline18);
    // addSimpleMarker2();

    //setSourceAndDestinationIcons();
  }

  void addSimpleMarker17() {
    MarkerId id = MarkerId('sourcePin');
    Marker marker = Marker(
      markerId: MarkerId('sourcePin'),
      icon: sourceIcon,
      position: Linea11Ida.SOURCE_LOCATION,
      infoWindow: InfoWindow(title: 'INICIO'),
      //draggable: false,
    );

    markers[id] = marker;
  }

  void addSimpleMarker18() {
    MarkerId id = MarkerId('destPin');
    Marker marker = Marker(
      markerId: MarkerId('destPin'),
      position: Linea11Ida.DEST_LOCATION,
      infoWindow: InfoWindow(title: 'DESTINO'),
      icon: destinationIcon,
      //draggable: false,
    );
    markers[id] = marker;
  }

  void saveTravelHistory(
      double tarifa, String id, double calification, String plate) async {
    TravelHistory travelHistory = new TravelHistory(
      idDriver: id,
      idClient: _authProvider.getUser().uid,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      tarifa: tarifa,
      calificationClient: calification,
      plate: plate,
    );

    await _travelHistoryProvider.create(travelHistory);

    refresh();
  }

  void rutaLinea2() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "2") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point4 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point4.add(latLang);
    }
    print('puntos:$point4');

    List<LatLng> distPoints2 = point4;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea3() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "3") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point4 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point4.add(latLang);
    }
    print('puntos:$point4');

    List<LatLng> distPoints2 = point4;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea4() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "4") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point4 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point4.add(latLang);
    }
    print('puntos:$point4');

    List<LatLng> distPoints2 = point4;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea5() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "5") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point5 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point5.add(latLang);
    }
    print('puntos:$point5');

    List<LatLng> distPoints2 = point5;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea6() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "6") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point6 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point6.add(latLang);
    }
    print('puntos:$point6');

    List<LatLng> distPoints2 = point6;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea7() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "7") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point7 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point7.add(latLang);
    }
    print('puntos:$point7');

    List<LatLng> distPoints2 = point7;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea8() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "8") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point8 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point8.add(latLang);
    }
    print('puntos:$point8');

    List<LatLng> distPoints2 = point8;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea9() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "9") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point9 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point9.add(latLang);
    }
    print('puntos:$point9');

    List<LatLng> distPoints2 = point9;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea10() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "10") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point10 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point10.add(latLang);
    }
    print('puntos:$point10');

    List<LatLng> distPoints2 = point10;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  void rutaLinea11() async {
    String datos;
    await FirebaseFirestore.instance
        .collection('Micros')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["linea"] == "11") {
          print("Linea del micro");
          print(doc["linea"]);

          datos = doc["geo"].toString();

          String origen = datos;
          RegExp exp = RegExp(r"\[*([-\d\.]*)*, *([-\d\.]*)*\]");
          Iterable<RegExpMatch> matches = exp.allMatches(origen);
          for (var grupo in matches) {
            listadb.add(
                [double.parse(grupo.group(1)), double.parse(grupo.group(2))]);
          }
          print('Lista de datos: $listadb');
        }
      });
    });
    print('puntos:${listadb.length}');

    List<LatLng> point11 = [];
    for (var i = 0; i < listadb.length; i++) {
      var latLang = LatLng(listadb[i][1], listadb[i][0]);
      point11.add(latLang);
    }
    print('puntos:$point11');

    List<LatLng> distPoints2 = point11;
    List<Polyline> distPolyline2 = [
      Polyline(
        polylineId: PolylineId('Linea000'),
        points: distPoints2,
        color: Colors.green,
        width: 3,
        //visible: mostrar,
        //fillColor: Color(0xFFFF1744).withOpacity(0.4),
      ),
    ];

    polyline.addAll(distPolyline2);
    listadb.clear();
    //distPolyline2.clear();
    refresh();
  }

  //Datos de rutas de cada linea ------------------------------------------------------------------------
  //Linea 1 Datos
  void mostrarMic1() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[4].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '1')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[4].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 2 Datos
  void mostrarMic2() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[0].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '2')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[0].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 3 Datos
  void mostrarMic3() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[1].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '3')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[1].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 4 Datos
  void mostrarMic4() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[5].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '4')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[5].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 5 Datos
  void mostrarMic5() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[2].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '5')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[2].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 6 Datos
  void mostrarMic6() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '6')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 2 Datos
  void mostrarMic7() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '7')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 8 Datos
  void mostrarMic8() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '8')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 8 Datos
  void mostrarMic9() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '9')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 10 Datos
  void mostrarMic10() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '10')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }

  //Linea 11 Datos
  void mostrarMic11() async {
    lista.clear();
    var document =
        (await FirebaseFirestore.instance.collection('Micros').get()).docs;
    print('datos del array');
    print(document[3].data()['lista'].length);

    await FirebaseFirestore.instance
        .collection('Micros')
        .where('linea', isEqualTo: '11')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Lista del micro");

        for (var i = 0; i < document[3].data()['lista'].length; i++) {
          print({doc['lista'][i]['name']});
          lista.add(' ${i + 1} -> ' + doc['lista'][i]['name'].toString());
          lista.add(
              '----------------------------------------------------------');
        }
      });
    });
    //lista.clear();
  }
}
