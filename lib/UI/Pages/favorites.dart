import 'package:flutter/material.dart';
import '../../Models/favorite_model.dart';
import '../widgets/main_menu.dart';
import 'fav_place_view.dart';

// ignore: must_be_immutable
class Favorites extends StatefulWidget {
  List<Favorite> favoritesList = [];
  Favorites(this.favoritesList, {super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

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
    return widget.favoritesList.isEmpty? const Center(
      child: Text('No hay Favoritos'),
    ) : ListView.builder(
      itemCount: widget.favoritesList.length,
      itemBuilder: (BuildContext context, int index) {
        return myItem(widget.favoritesList[index]);
      },
    );
  }

  myItem(Favorite favorite) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  FavPlaceView(favorite))
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(favorite.name, style: const TextStyle(fontSize: 20, color: Colors.red)),
      subtitle: Text('${favorite.city},${favorite.state}',style: const TextStyle(fontSize: 18)),
    );
  }
}