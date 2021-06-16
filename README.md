# Flutter Adotech Scanovate Plugin


A Flutter plugin for iOS and Android allowing access to the Scanovate API now with null safety.
## Docs

https://adocolumbia.ado-tech.com/documentation/sdkandroidios.html
https://adocolumbia.ado-tech.com/documentation/serviciosRest.html
## Installation

First, add scanovateplugin as a dependency in your pubspec.yaml file.

`dependencies:
  puntored_plugin_flutter: ^2.0.0`
  
then import package

`import 'package:puntored_plugin_flutter/puntored_plugin_flutter.dart';`

the plugin returns the response in json string format.  
### iOS
Add two rows to the `ios/Runner/Info.plist:`

* one with the key `Privacy - Camera Usage Description` and a usage description.
* and one with the key `Privacy - Location When In Use Usage Description` and a usage description.I

Or in text format add the key:


    <key>NSCameraUsageDescription</key>
    <string>Use for liveness</string>
	<key>NSLocationWhenInUseUsageDescription</key>
 	<string>$(PRODUCT_NAME) requiere acceso a tu ubicación para realizar la verificación de identidad</string>

Change the target iOS  version to 11 (or higher) in your `PodFile`

Change the minimum iOS  version to 11 (or higher) in your `project general tab`

Run `pod install` or `pod update` if you already have run install

### Android

Change the minimum Android sdk version to 19 (or higher) in your `android/app/build.gradle` file

### Example

Here is a small example flutter app calling the plugin. 

For use you have to provide valid data

    import 'package:flutter/material.dart';  
    import 'dart:async';  
    import 'package:flutter/services.dart';  
    import 'package:puntored_plugin_flutter/puntored_plugin_flutter.dart';
	  void main() {  
	  runApp(MyApp());  
	}	 	 
  
	class MyApp extends StatefulWidget {  
	  @override  
	  _MyAppState createState() => _MyAppState();  
	}  
  
	class _MyAppState extends State<MyApp> {  
	  String _platformVersion = 'Unknown';  
	  String _resultScanovate = '';  
	  bool pressedValidate = false;  
	 final documentNumberController = TextEditingController();  
	 final individualFingerCode = TextEditingController();  
	  
	  String documentType = "3";  
	  int productId = 1;  
	  String projectName = "Nombre proyecto";  
	  String apiKey = "key api";  
	  String urlSdk = "url sdk";  
	  String documentNumber;  
	  String codeFinger;  
	  bool verification = false;
	  String userName = "";
	  String password = "";  
	  String _scanovateResult = "";  
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
	  } on PlatformException {  
	      platformVersion = 'Failed to get platform version.';  
	  }  
	  
	    // If the widget was removed from the tree while the asynchronous platform  
	 // message was in flight, we want to discard the reply rather than calling // setState to update our non-existent appearance.  if (!mounted) return;  
	  
	  setState(() {  
	      _platformVersion = platformVersion;  
	  });  
	  }  
	  
	  Future<void> _scanovate(BuildContext context) async {  
	    String response;  
	  // Platform messages may fail, so we use a try/catch PlatformException.  
	  try {  
	      documentNumber = documentNumberController.text;  
	  codeFinger = individualFingerCode.text;  
	  response = await Flutterscanovateplugin.callScanovate(verification, documentType, productId, projectName, apiKey, urlSdk, documentNumber, codeFinger, userName, password);  
	  } on PlatformException {  
	      response = 'Failed to get platform version.';  
	  }  
	  
	    // If the widget was removed from the tree while the asynchronous platform  
	 // message was in flight, we want to discard the reply rather than calling // setState to update our non-existent appearance.  if (!mounted) return;  
	  
	  _showAlert(response);  
	  setState(() {  
	      _resultScanovate = response;  
	  });  
	  }  
	  final navigatorKey = GlobalKey<NavigatorState>();  
	 void _showAlert(String message) {  
	    final context = navigatorKey.currentState.overlay.context;  
	  showDialog(  
	        context: context,  
	  builder: (context) => AlertDialog(  
	          title: Text("Test"),  
	  content: Text(message),  
	  )  
	    );  
	  }  
	  
	  @override  
	  Widget build(BuildContext context) {  
	    return new MaterialApp(  
	        navigatorKey: navigatorKey,  
	  home: new Scaffold(  
	        appBar: AppBar(  
	          // Here we take the value from the MyHomePage object that was created by  
	 // the App.build method, and use it to set our appbar title.  title: Text('Lanzador El Rosado'),  
	  ),  
	  body: Center(  
	          // Center is a layout widget. It takes a single child and positions it  
	 // in the middle of the parent.  child: Column(  
	            // Column is also a layout widget. It takes a list of children and  
	 // arranges them vertically. By default, it sizes itself to fit its // children horizontally, and tries to be as tall as its parent. // // Invoke "debug painting" (press "p" in the console, choose the // "Toggle Debug Paint" action from the Flutter Inspector in Android // Studio, or the "Toggle Debug Paint" command in Visual Studio Code) // to see the wireframe for each widget. // // Column has various properties to control how it sizes itself and // how it positions its children. Here we use mainAxisAlignment to // center the children vertically; the main axis here is the vertical // axis because Columns are vertical (the cross axis would be // horizontal).  mainAxisAlignment: MainAxisAlignment.center,  
	  children: <Widget>[  
	              !pressedValidate ? RaisedButton(  
	                onPressed: () {  
	                  this.setState(() {  
	                    pressedValidate = true;  
	  });  
	  },  
	  textColor: Colors.white,  
	  padding: const EdgeInsets.all(0.0),  
	  child: const Text('Verificar', style: TextStyle(fontSize: 20)),  
	  color: Color(0xFF0D47A1),  
	  
	  ): SizedBox(),  
	  pressedValidate ? new Container(  
	                  width: 300 ,  
	  child:  
	                  TextField(  
	                      controller: documentNumberController,  
	  obscureText: false,  
	  keyboardType: TextInputType.number,  
	  decoration: InputDecoration(  
	                        border: OutlineInputBorder(),  
	  labelText: 'Número de cédula',  
	  )  
	                  )  
	              )  
	                  : SizedBox(),  
	  SizedBox(height: 40),  
	  pressedValidate ? new Container(  
	                  width: 300 ,  
	  child:  
	                  TextField(  
	                      controller: individualFingerCode,  
	  obscureText: false,  
	  keyboardType: TextInputType.text,  
	  decoration: InputDecoration(  
	                        border: OutlineInputBorder(),  
	  labelText: 'Código dactilar',  
	  )  
	                  )  
	              )  
	                  : SizedBox(),  
	  SizedBox(height: 40),  
	  pressedValidate ? RaisedButton(  
	                onPressed: () {  
	                  _scanovate(context);  
	  },  
	  textColor: Colors.white,  
	  padding: const EdgeInsets.all(0.0),  
	  child: const Text('Enviar', style: TextStyle(fontSize: 20)),  
	  color: Color(0xFF0D47A1),  
	  
	  ): SizedBox(),  
	  pressedValidate ? RaisedButton(  
	                onPressed: () {  
	                  this.setState(() {  
	                    pressedValidate = false;  
	  });  
	  },  
	  textColor: Colors.white,  
	  padding: const EdgeInsets.all(0.0),  
	  child: const Text('Volver', style: TextStyle(fontSize: 20)),  
	  color: Color(0xFF0D47A1),  
	  
	  ): SizedBox()  
	            ],  
	  ),  
	  ),  
	  // This trailing comma makes auto-formatting nicer for build methods.  
	  )  
	    );  
	  }  
	  
	  
	}
