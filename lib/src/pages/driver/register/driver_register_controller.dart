import 'package:app_micro_flutter/src/models/driver.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/driver_provider.dart';
import 'package:app_micro_flutter/src/utils/my_progress_dialog.dart';
import 'package:app_micro_flutter/src/utils/snackbar.dart' as utils;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DriverRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController lineaController = new TextEditingController();

  TextEditingController pin1Controller = new TextEditingController();
  TextEditingController pin2Controller = new TextEditingController();
  TextEditingController pin3Controller = new TextEditingController();
  TextEditingController pin4Controller = new TextEditingController();
  TextEditingController pin5Controller = new TextEditingController();
  TextEditingController pin6Controller = new TextEditingController();

  AuthProvider _authProvider;
  DriverProvider _driverProvider;
  ProgressDialog _progressDialog;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    //getDataPlate();
  }

  getDataPlate() {
    FirebaseFirestore.instance
        .collection('Valid')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["plate"] == 'ASC-124') {
          print('Placa de vehiculo existente para registro: ${doc["plate"]}');
        } else {
          print('NO existe en el sistema');
        }
        String lista = doc["plate"];
        //print(doc["plate"]);
        print(lista);
      });
    });
  }

  void register() async {
    String username = usernameController.text;
    String email = emailController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String password = passwordController.text.trim();
    String linea = lineaController.text.trim();

    String pin1 = pin1Controller.text.trim();
    String pin2 = pin2Controller.text.trim();
    String pin3 = pin3Controller.text.trim();
    String pin4 = pin4Controller.text.trim();
    String pin5 = pin5Controller.text.trim();
    String pin6 = pin6Controller.text.trim();

    String plate = '$pin1$pin2$pin3-$pin4$pin5$pin6';

    print('Email: $email');
    print('Password: $password');

    if (username.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      print('debes ingresar todos los campos');
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      print('Las contraseñas no coinciden');
      utils.Snackbar.showSnackbar(context, key, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      print('el password debe tener al menos 6 caracteres');
      utils.Snackbar.showSnackbar(
          context, key, 'el password debe tener al menos 6 caracteres');
      return;
    }

    FirebaseFirestore.instance
        .collection('Valid')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc["plate"] == plate) {
          utils.Snackbar.showSnackbar(context, key, 'Creando registro.....');
          print('Placa de vehiculo existente para registro: ${doc["plate"]}');
          _progressDialog.show();
          try {
            bool isRegister = await _authProvider.register(email, password);

            if (isRegister) {
              Driver driver = new Driver(
                id: _authProvider.getUser().uid,
                email: _authProvider.getUser().email,
                username: username,
                password: password,
                plate: plate,
                linea: linea,
              );

              await _driverProvider.create(driver);

              _progressDialog.hide();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'driver/map', (route) => false);
              utils.Snackbar.showSnackbar(
                  context, key, 'El usuario se registro correctamente');
              print('El usuario se registro correctamente');
            } else {
              _progressDialog.hide();
              print('El usuario no se pudo registrar');
            }
          } catch (error) {
            _progressDialog.hide();
            utils.Snackbar.showSnackbar(context, key, 'Error: $error');
            print('Error: $error');
          }
        } else {
          utils.Snackbar.showSnackbar(context, key, 'No Existe en el Sistema');
          print('NO existe en el sistema');
        }
        String lista = doc["plate"];
        //print(doc["plate"]);
        print(lista);
      });
    });

    // _progressDialog.show();

    // try {
    //   bool isRegister = await _authProvider.register(email, password);

    //   if (isRegister) {
    //     Driver driver = new Driver(
    //       id: _authProvider.getUser().uid,
    //       email: _authProvider.getUser().email,
    //       username: username,
    //       password: password,
    //       plate: plate,
    //       linea: linea,
    //     );

    //     await _driverProvider.create(driver);

    //     _progressDialog.hide();
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, 'driver/map', (route) => false);
    //     utils.Snackbar.showSnackbar(
    //         context, key, 'El usuario se registro correctamente');
    //     print('El usuario se registro correctamente');
    //   } else {
    //     _progressDialog.hide();
    //     print('El usuario no se pudo registrar');
    //   }
    // } catch (error) {
    //   _progressDialog.hide();
    //   utils.Snackbar.showSnackbar(context, key, 'Error: $error');
    //   print('Error: $error');
    // }
  }
}
