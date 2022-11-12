import '../screens/countries_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.blueGrey,
          cardColor: Colors.white60,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Axiforma',
              fontSize: 14,
            ),
            headline2: TextStyle(
              color: Color.fromARGB(255, 102, 98, 98),
              fontFamily: 'Axiforma',
              //fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          fontFamily: 'Axiforma'),
      darkTheme: ThemeData(
          hintColor: Colors.white,
          cardColor: Colors.transparent,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontFamily: 'Axiforma',
              //fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            headline2: TextStyle(
              color: Colors.white54,
              fontFamily: 'Axiforma',
              fontSize: 14,
              //fontWeight: FontWeight.normal,
            ),
          ),
          brightness: Brightness.dark,
          backgroundColor: Color.fromARGB(255, 2, 18, 31),
          fontFamily: 'Axiforma'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CountriesScreen();
  }
}
