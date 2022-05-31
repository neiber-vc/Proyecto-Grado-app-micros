import 'package:flutter/material.dart';
import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:app_micro_flutter/src/models/travel_history.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/driver_provider.dart';
import 'package:app_micro_flutter/src/providers/travel_history_provider.dart';

class ClientHistoryDetailController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TravelHistoryProvider _travelHistoryProvider;
  AuthProvider _authProvider;
  DriverProvider _driverProvider;

  TravelHistory travelHistory;

  String idTravelHistory;

  Driver driver;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _travelHistoryProvider = new TravelHistoryProvider();
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();

    idTravelHistory = ModalRoute.of(context).settings.arguments as String;
    getTravelHistoryInfo();
    print(idTravelHistory);
  }

  void getTravelHistoryInfo() async {
    travelHistory = await _travelHistoryProvider.getById(idTravelHistory);
    getDriverInfo(travelHistory.idDriver);
  }

  void getDriverInfo(String idDriver) async {
    driver = await _driverProvider.getById(idDriver);
    refresh();
  }
}
