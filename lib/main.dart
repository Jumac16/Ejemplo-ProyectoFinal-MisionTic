import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Models/user_model.dart';
import 'UI/Pages/login_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
    runApp(const TurismoPorColombia());
  });
}

// ignore: must_be_immutable
class TurismoPorColombia extends StatelessWidget {
  const TurismoPorColombia({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paisajeando Por Colombia',
      home: LoginBody(),
    );
  }
}