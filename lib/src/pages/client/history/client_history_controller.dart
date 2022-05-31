import 'package:app_micro_flutter/src/models/travel_history.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/travel_history_provider.dart';
import 'package:flutter/material.dart';

class ClientHistoryController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TravelHistoryProvider _travelHistoryProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _travelHistoryProvider = new TravelHistoryProvider();
    _authProvider = new AuthProvider();

    refresh();
  }

  Future<List<TravelHistory>> getAll() async {
    return await _travelHistoryProvider
        .getByIdClient(_authProvider.getUser().uid);
  }

  void goToDetailHistory(String id) {
    Navigator.pushNamed(context, 'client/history/detail', arguments: id);
  }
}
