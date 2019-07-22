import 'package:flutter_driver/flutter_driver.dart';
//import 'package:flutter_driver/driver_extension.dart';
//import 'package:spotify_example/main.dart' as app;

void main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  await driver.requestData(null, timeout: const Duration(minutes: 1));
  driver.close();
//  enableFlutterDriverExtension();
//
//  app.main();
}

