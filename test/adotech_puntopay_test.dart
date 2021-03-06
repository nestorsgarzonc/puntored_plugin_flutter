import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adotech_puntopay/adotech_puntopay.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutterscanovateplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Flutterscanovateplugin.platformVersion, '42');
  });
}
