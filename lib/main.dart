import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screen/homepage.dart';
import 'package:note_keeper/screen/second_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
        'second':(context)=>Second_Screen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    ),
  );
}
