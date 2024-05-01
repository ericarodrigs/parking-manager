import 'package:flutter/material.dart';
import 'package:parking_manager/my_app.dart';
import 'package:parking_manager/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}
