import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_study_app/src/provider/category_repository.dart';
import 'package:virtual_study_app/src/provider/permission_repository.dart';

import 'src/provider/auth_repository.dart';
import 'src/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PermissionRepository>(
          create: (_) => PermissionRepository()),
      ChangeNotifierProvider<CategoryRepository>(
          create: (_) => CategoryRepository()),
      ChangeNotifierProvider<AuthRepository>(
        create: (_) => AuthRepository(),
      ),
    ],
    child: MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
  ));
}
