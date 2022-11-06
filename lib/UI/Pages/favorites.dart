import 'package:flutter/material.dart';
import '../widgets/main_menu.dart';
import 'place_view.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  int favorites = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(),
        drawer: mainMenu(context),
        body: favoritesBody()
    );
  }


  myAppbar() {
    return AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      title: const Text('Favoritos', style: TextStyle(color: Colors.white),),
    );
  }

  favoritesBody() {
    return favorites == 0 ? const Center(
      child: Text('No hay Favoritos'),
    ) : ListView.builder(
      itemCount: favorites,
      itemBuilder: (BuildContext context, int index) {
        return myItem(index);
      },
    );
  }

  myItem(index) {
    return ListTile(
      onTap: (){
        /*Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaceView(null))
        );*/
      },
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text('Item ${index+1}', style: const TextStyle(fontSize: 20),),
    );
  }
}