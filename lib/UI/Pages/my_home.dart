import 'package:flutter/material.dart';
import '../../Models/user_model.dart';
import '../widgets/main_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: myBody(),
      drawer: mainMenu(context),
    );
  }

  myAppbar() {
    return AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      title: const Text('Home', style: TextStyle(color: Colors.white),),
    );
  }

  myBody() {
    return const Center(
      child: Text('Bienvenido a Colombia', style: TextStyle(fontSize: 25),),
    );
  }
}
