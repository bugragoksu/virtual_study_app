import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/screens/auth/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen()));
}
