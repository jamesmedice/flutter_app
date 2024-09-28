import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/authentication_wrapper.dart';
import 'locator.dart';
import 'l18n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GoogleProvider(
      clientId:
          '834180051645-bgsb15vh4iu3udh6aoi75juf86745n9f.apps.googleusercontent.com');
          
  setupServices();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MeinApp(prefs));
}

class MeinApp extends StatelessWidget {
  final SharedPreferences prefs;

  MeinApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConSex',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      supportedLocales: [Locale('en', 'US'), Locale('it', 'IT')],
      localizationsDelegates: [
        const AppLocalizationsDelegate(defaultLocale: Locale('it')),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: AuthenticationWrapper(this.prefs),
    );
  }
}
