import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_study_app/src/provider/category_repository.dart';

import 'src/provider/user_repository.dart';
import 'src/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CategoryRepository>(
          create: (_) => CategoryRepository()),
      ChangeNotifierProvider<UserRepository>(
        create: (_) => UserRepository(),
      ),
    ],
    child: MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
  ));
}
