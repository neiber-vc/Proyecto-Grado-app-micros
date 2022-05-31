import 'dart:io';

import 'package:app_micro_flutter/src/models/client.dart';
import 'package:app_micro_flutter/src/providers/auth_provider.dart';
import 'package:app_micro_flutter/src/providers/client_provider.dart';
import 'package:app_micro_flutter/src/providers/storage_provider.dart';
import 'package:app_micro_flutter/src/utils/my_progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:app_micro_flutter/src/utils/snackbar.dart' as utils;

class ClientEditController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;
  StorageProvider _storageProvider;

  PickedFile pickedFile;
  File imageFile;

  Client client;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _storageProvider = new StorageProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    getUserInfo();
  }

  void getUserInfo() async {
    client = await _clientProvider.getById(_authProvider.getUser().uid);
    usernameController.text = client.username;
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = FlatButton(
        onPressed: () {
          getImageFromGallery(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButton = FlatButton(
        onPressed: () {
          getImageFromGallery(ImageSource.camera);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future getImageFromGallery(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('No se sleeciono ninguna imagen');
    }
    Navigator.pop(context);
    refresh();
  }

  void update() async {
    String username = usernameController.text;

    if (username.isEmpty) {
      print('El usuario debe de ingresar todo los campos');
      utils.Snackbar.showSnackbar(
          context, key, 'El usuario debe de ingresar todo los campos');
      return;
    }

    _progressDialog.show();

    if (pickedFile == null) {
      Map<String, dynamic> data = {
        'image': client?.image ?? null,
        'username': username,
      };
      await _clientProvider.update(data, _authProvider.getUser().uid);
      _progressDialog.hide();
    } else {
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'image': imageUrl,
        'username': username,
      };
      await _clientProvider.update(data, _authProvider.getUser().uid);
    }

    _progressDialog.hide();

    utils.Snackbar.showSnackbar(
        context, key, 'Los datos se actualizaron correctamente');
  }
}
