import 'package:app_micro_flutter/src/models/client.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/client_provider.dart';
import 'package:app_micro_flutter/src/utils/my_progress_dialog.dart';
import 'package:app_micro_flutter/src/utils/snackbar.dart' as utils;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ClientRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    getDataPlate();
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
        print(doc["plate"]);
      });
    });
  }

  void register() async {
    String username = usernameController.text;
    String email = emailController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String password = passwordController.text.trim();

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
      print('Las contrase??as no coinciden');
      utils.Snackbar.showSnackbar(context, key, 'Las contrase??as no coinciden');
      return;
    }

    if (password.length < 6) {
      print('el password debe tener al menos 6 caracteres');
      utils.Snackbar.showSnackbar(
          context, key, 'el password debe tener al menos 6 caracteres');
      return;
    }

    _progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);

      if (isRegister) {
        Client client = new Client(
            id: _authProvider.getUser().uid,
            email: _authProvider.getUser().email,
            username: username,
            password: password);

        await _clientProvider.create(client);

        _progressDialog.hide();
        // Navigator.pushNamedAndRemoveUntil(
        //     context, 'client/map', (route) => false);

        utils.Snackbar.showSnackbar(
            context, key, 'El usuario se registro correctamente');

        senVerificationEmail();
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
  }

  void senVerificationEmail() async {
    await _authProvider.getUser().sendEmailVerification();

    utils.Snackbar.showSnackbar(
        context, key, 'se envio a su correo un link de verificacion');

    Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
  }
}
