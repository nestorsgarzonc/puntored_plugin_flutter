import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:adotech_puntopay/adotech_puntopay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool pressedValidate = false;
  final documentNumberController = TextEditingController();
  final individualFingerCode = TextEditingController();

  String documentType = "1";
  int productId = 1;
  String projectName = "puntoredqa";
  String apiKey = "db92efc69991";
  String urlSdk = "https://adocolombia-qa.ado-tech.com/puntoredqa/api/";
  String documentNumber;
  bool verification = false;
  String userName = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Flutterscanovateplugin.platformVersion;
      log(platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future<void> _scanovate(BuildContext context) async {
    String response;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      documentNumber = documentNumberController.text;

      response = await Flutterscanovateplugin.callScanovate(verification, documentType, productId,
          projectName, apiKey, urlSdk, documentNumber, userName, password);
    } on PlatformException {
      response = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _showAlert(response);
  }

  final navigatorKey = GlobalKey<NavigatorState>();
  void _showAlert(String message) {
    final context = navigatorKey.currentState.overlay.context;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Test"),
              content: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        navigatorKey: navigatorKey,
        home: new Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Lanzador PuntoRed'),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !pressedValidate
                    ? ElevatedButton(
                        onPressed: () {
                          this.setState(() {
                            _scanovate(context);
                          });
                        },
                        child: const Text('Enrolar', style: TextStyle(fontSize: 20)),
                      )
                    : SizedBox(),
                !pressedValidate
                    ? ElevatedButton(
                        onPressed: () {
                          this.setState(() {
                            verification = true;
                            pressedValidate = true;
                          });
                        },
                        child: const Text('Verificar', style: TextStyle(fontSize: 20)),
                      )
                    : SizedBox(),
                pressedValidate
                    ? new Container(
                        width: 300,
                        child: TextField(
                            controller: documentNumberController,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Número de cédula',
                            )))
                    : SizedBox(),
                SizedBox(height: 40),
                pressedValidate
                    ? ElevatedButton(
                        onPressed: () {
                          _scanovate(context);
                        },
                        child: const Text('Enviar', style: TextStyle(fontSize: 20)),
                      )
                    : SizedBox(),
                pressedValidate
                    ? ElevatedButton(
                        onPressed: () {
                          this.setState(() {
                            pressedValidate = false;
                          });
                        },
                        child: const Text('Volver', style: TextStyle(fontSize: 20)),
                      )
                    : SizedBox()
              ],
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
