import 'package:dashboarweb/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants.dart';
import 'controllers/menu_app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized with the Firebase options for web
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC0NyBI9wy66gCNUgXumHP0ea_Q8kkRP3M",
      authDomain: "myweb-c0542.firebaseapp.com",
      projectId: "myweb-c0542",
      storageBucket: "myweb-c0542.appspot.com",
      messagingSenderId: "362060502803",
      appId: "1:362060502803:web:67b9ad53d522fbd0ef6ce6",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
