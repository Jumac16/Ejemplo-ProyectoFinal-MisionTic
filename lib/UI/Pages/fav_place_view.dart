import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:paisajeando_colombia/Controller/db_manager.dart';
import 'package:paisajeando_colombia/UI/Pages/my_home.dart';
import 'package:paisajeando_colombia/UI/Widgets/snack_bar.dart';
import '../../Models/favorite_model.dart';
import '../Widgets/main_menu.dart';


// ignore: must_be_immutable
class FavPlaceView extends StatefulWidget {
  Favorite site;
  FavPlaceView(this.site, {super.key});

  @override
  State<FavPlaceView> createState() => _FavPlaceViewState();
}

class _FavPlaceViewState extends State<FavPlaceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: favPlaceBody(),
      drawer: mainMenu(context),
    );
  }

  myAppbar() {
    return AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      title: const Text(
        'Sitio Turístico',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  favPlaceBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FadeInImage(
              fadeInDuration: const Duration(seconds: 3),
              placeholder: const NetworkImage(
                  'https://acegif.com/wp-content/uploads/loading-11.gif'),
              image: NetworkImage(
                  widget.site.urlImage)),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Información:',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Accordion(
          headerBackgroundColor: Colors.redAccent,
          contentBorderColor: Colors.redAccent,
          openAndCloseAnimation: Accordion.sectionAnimation,
          contentHorizontalPadding: 10,
          children: [
            AccordionSection(
                header: const Text('Destino', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site.name)),
            AccordionSection(
                header: const Text('Descripción', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site.description)),
            AccordionSection(
                header: const Text('Ciudad', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site.city)
            ),
            AccordionSection(
                header: const Text('Departamento', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site.state)
            ),
        ]),
        const SizedBox(
          height: 15,
        ),
        TextButton(
            onPressed: (){},
            child: const Text('Ver en Google Maps', style: TextStyle(fontSize: 18, color: Colors.black),)
        ),
        TextButton(
            onPressed: () async{
              await DbManager.db.deleteFavorite(widget.site).then((value){
                mySnackbarAction('Sitio Eliminado de Favoritos', context).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                });
              });
            },
            child: const Text('Eliminar de Favoritos', style: TextStyle(fontSize: 18, color: Colors.black),)
        )
      ],
    ));
  }

}
