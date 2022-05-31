import 'dart:async';

import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:app_micro_flutter/src/models/client.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/driver_provider.dart';
import 'package:app_micro_flutter/src/providers/client_provider.dart';
import 'package:app_micro_flutter/src/utils/my_progress_dialog.dart';
import 'package:app_micro_flutter/src/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:app_micro_flutter/src/utils/snackbar.dart' as utils;

class LoginController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;
  ProgressDialog _progressDialog;
  DriverProvider _driverProvider;
  ClientProvider _clientProvider;

  SharedPref _sharedPref;
  String _typeUser;

  // User user;
  // Timer timer;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();
    _clientProvider = new ClientProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    _sharedPref = new SharedPref();
    _typeUser = await _sharedPref.read('typeUser');

    print('============== TIPO DE USUARIO===============');
    print(_typeUser);

    // timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   checkEmailVerified();
    // });
  }

  void goToRegisterPage() {
    if (_typeUser == 'client') {
      Navigator.pushNamed(context, 'client/register');
    } else {
      Navigator.pushNamed(context, 'driver/register');
    }
  }

  // Future<void> checkEmailVerified() async {
  //   user = _authProvider.getUser();
  //   await user.reload();
  //   if (user.emailVerified) {
  //     timer.cancel();
  //     print("Se verifico el correo");
  //     login();
  //   } else {
  //     print("Verifique su correo por favor");
  //   }
  // }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    _progressDialog.show();

    try {
      bool isLogin = await _authProvider.login(email, password);
      _progressDialog.hide();

      if (isLogin) {
        print('El usuario esta logeado');

        if (_typeUser == 'client') {
          Client client =
              await _clientProvider.getById(_authProvider.getUser().uid);
          print('CLIENT: $client');

          if (client != null) {
            print('El cliente no es nulo');
            Navigator.pushNamedAndRemoveUntil(
                context, 'client/map', (route) => false);
          } else {
            print('El cliente si es nulo');
            utils.Snackbar.showSnackbar(
                context, key, 'El usuario no es valido');
            await _authProvider.signOut();
          }
        } else if (_typeUser == 'driver') {
          Driver driver =
              await _driverProvider.getById(_authProvider.getUser().uid);
          print('DRIVER: $driver');

          if (driver != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'driver/map', (route) => false);
          } else {
            utils.Snackbar.showSnackbar(
                context, key, 'El usuario no es valido');
            await _authProvider.signOut();
          }
        }
      } else {
        utils.Snackbar.showSnackbar(
            context, key, 'El usuario no se pudo autenticar');
        print('El usuario no se pudo autenticar');
      }
    } catch (error) {
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      _progressDialog.hide();
      print('Error: $error');
    }
  }
}
