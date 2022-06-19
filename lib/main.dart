import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joris/screens/favourites_screen.dart';
import 'package:joris/screens/jokes_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JorisApp());
}

class JorisApp extends StatelessWidget {
  const JorisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const JokesScreen(),
        '/favourites': (BuildContext context) => const FavouritesScreen(),
      },
    );
  }
}
