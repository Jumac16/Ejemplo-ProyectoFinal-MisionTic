import 'package:flutter/material.dart';
import '../../Controller/db_manager.dart';
import '../../Models/favorite_model.dart';
import '../Pages/favorites.dart';
import '../Pages/login_page.dart';
import '../Pages/my_home.dart';
import '../Pages/places_list.dart';


List<Favorite> favoriteslist = [];

_getFavorite() async{
  favoriteslist = await DbManager.db.favoritesList();
}

Widget mainMenu(BuildContext context){

  return Drawer(
    shape: const RoundedRectangleBorder(),
    child: ListView(
      padding: const EdgeInsets.all(0),
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:  Column(
            children: const [
              Text('Paisajeando Por Colombia',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20)),
            Text('',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 20)),
            ]
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          iconColor: Colors.red,
          title: const Text('Inicio', style: TextStyle(fontSize: 15)),
          leading: const Icon(Icons.home),
          textColor: Colors.red,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
          },
        ),
        const SizedBox(
          height: 3,
        ),
        ListTile(
          iconColor: Colors.red,
          title: const Text('Lugares', style: TextStyle(fontSize: 15)),
          leading: const Icon(Icons.place),
          textColor: Colors.red,
          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> const Places()));

          },
        ),
        const SizedBox(
          height: 3,
        ),
        ListTile(
          iconColor: Colors.red,
          title: const Text('Favoritos', style: TextStyle(fontSize: 15)),
          leading: const Icon(Icons.star),
          textColor: Colors.red,
          onTap: () {
            _getFavorite();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Favorites(favoriteslist)));
          },
        ),
        const SizedBox(
          height: 3,
        ),
        ListTile(
          iconColor: Colors.red,
          title: const Text('Cerrar Sesión', style: TextStyle(fontSize: 15)),
          leading: const Icon(Icons.logout_outlined),
          textColor: Colors.red,
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  const LoginBody()),
                    (route) => false);
          },
        ),
        const SizedBox(
          height: 3,
        ),
      ],
    ),
  );
}