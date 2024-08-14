import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Screens/homepage.dart';
import 'package:shopping_app/Screens/loginpage.dart';
import 'package:shopping_app/Screens/registerpage.dart';
import 'package:shopping_app/controllers/logincontroller.dart';
import 'package:shopping_app/firebase_options.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
Get.put(Logincontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
       elevatedButtonTheme: ElevatedButtonThemeData(
         style: ElevatedButton.styleFrom(
           backgroundColor: Colors.indigoAccent,
           foregroundColor: Colors.white
         )
       ),
        useMaterial3: true,
      ),
      home:Registerpage(),
    );
  }
}
