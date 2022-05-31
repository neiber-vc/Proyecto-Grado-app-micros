import 'package:app_micro_flutter/src/pages/client/edit/client_edit_controller.dart';
import 'package:app_micro_flutter/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

class ClientEditPage extends StatefulWidget {
  ClientEditPage({Key key}) : super(key: key);

  @override
  _ClientEditPageState createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage> {
  ClientEditController _con = new ClientEditController();

  @override
  void initState() {
    super.initState();
    print('INIT STATE');
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(),
      bottomNavigationBar: _buttonRegister(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 20),
            _bannerApp(),
            _textLogin(),
            _textFieldUserName(),
          ],
        ),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.busColor,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _con.showAlertDialog,
              child: CircleAvatar(
                backgroundImage: _con.imageFile != null
                    ? FileImage(_con.imageFile)
                    : _con.client?.image != null
                        ? NetworkImage(_con.client?.image)
                        : AssetImage(
                            _con.imageFile?.path ?? 'assets/img/profile.jpg',
                          ),
                radius: 50,
              ),
              // child: _con.client.image != null
              //     ? Card(
              //         child: Container(
              //           height: 140.0,
              //           width: 150,
              //           child: Image.network(
              //             _con.client?.image,
              //             // _con.imageFile,
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       )
              //     : Card(
              //         child: Container(
              //           height: 150,
              //           width: 150,
              //           padding: EdgeInsets.all(15.0),
              //           child: Image(
              //             image: AssetImage(
              //                 _con.imageFile?.path ?? 'assets/img/profile.jpg'),
              //           ),
              //         ),
              //       ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                _con.client?.email ?? '',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        'EDITAR PERFIL',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.usernameController,
        decoration: InputDecoration(
          hintText: 'Pepito Perez',
          labelText: 'Nombre de Usuario',
          suffixIcon: Icon(
            Icons.person_outline,
            color: utils.Colors.busColor,
          ),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.update,
        text: 'Actualizar',
        color: utils.Colors.busColor,
        textColor: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
