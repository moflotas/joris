import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joris/routes.dart';
import 'package:joris/screens/big_joke_screen.dart';
import 'package:joris/screens/home.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const JorisApp());
}

class JorisApp extends StatelessWidget {
  const JorisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.changeTheme(
      ThemeData(
        backgroundColor: Colors.amber[800],
        primaryColor: Colors.white,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.main,
      getPages: [
        GetPage(name: Routes.main, page: () => Home()),
        GetPage(name: Routes.cardBigPage, page: () => const JokesBigScreen()),
      ],
    );
  }
}
