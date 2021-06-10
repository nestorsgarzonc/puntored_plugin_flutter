import 'dart:async';

import 'package:flutter/services.dart';

class Flutterscanovateplugin {
  static const MethodChannel _channel =
      const MethodChannel('flutterscanovateplugin');

  /// get the platform version.
  ///

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Call the scanovate API.
  ///
  /// @param verification verification field.
  /// @param documentType the documentType field.
  /// @param documentType the productId field.
  /// @param documentType the projectName field.
  /// @param documentType the apiKey field.
  /// @param documentType the urlSdk field.
  /// @param documentType the documentNumber field.
  /// @param documentType the codeFinger field.
  /// @param documentType the userName field.
  /// @param documentType the password field.
  /// @returns The response in json string format.

  static Future<String> callScanovate(
      bool verification,
      String documentType,
      int productId,
      String projectName,
      String apiKey,
      String urlSdk,
      String documentNumber,
      String userName,
      String password) async {
    final String response = await _channel.invokeMethod('callScanovate', {
      "data": {
        'documentType': documentType,
        'productId': productId,
        'projectName': projectName,
        'apiKey': apiKey,
        'urlSdk': urlSdk,
        'documentNumber': documentNumber,
        'verification': verification,
        'userName':userName,
        'password':password
      }
    });
    return response;
  }
}
