import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:paisajeando_colombia/UI/Widgets/snack_bar.dart';
import '../../Models/favorite_model.dart';
import '../Widgets/main_menu.dart';
import './/Controller/db_manager.dart';


// ignore: must_be_immutable
class PlaceView extends StatefulWidget {
  late QueryDocumentSnapshot site;
  PlaceView(this.site, {super.key});

  @override
  State<PlaceView> createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  bool isliked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: placeBody(),
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

  placeBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          margin: const EdgeInsets.all(3.5),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Column(
              children: [
                SizedBox(
                  height: 400,
                child: FadeInImage(
                    fadeInDuration: const Duration(seconds: 3),
                    placeholder: const NetworkImage(
                        'https://acegif.com/wp-content/uploads/loading-11.gif'),
                    image: NetworkImage(widget.site['Url_imagen'],scale: 1.7)
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ActionChip(
                      label: const Text('Favorito'),
                      avatar: Icon(Icons.favorite, color: isliked? Colors.red: Colors.grey),
                      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      onPressed: (){
                        setState(() {
                          isliked = !isliked;
                        });
                        _onlikedbutton();
                      },
                    ),
                  ),
                ],
            ),
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
                content: Text(widget.site['Nombre'])),
            AccordionSection(
                header: const Text('Descripción', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site['Descripcion'])),
            AccordionSection(
                header: const Text('Ciudad', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site['Ciudad'])
            ),
            AccordionSection(
                header: const Text('Departamento', style: TextStyle(fontSize: 18, color: Colors.white),),
                content: Text(widget.site['Departamento'])
            ),
        ]),
        const SizedBox(
          height: 15,
        ),
        TextButton(
            onPressed: (){},
            child: const Text('Ver en Google Maps', style: TextStyle(fontSize: 18, color: Colors.black),)
        )
      ],
    ));
  }

  _onlikedbutton() async{
    final favorite = Favorite(widget.site['Nombre'], widget.site['Ciudad'], widget.site['Departamento'], widget.site['Descripcion'], widget.site['Url_imagen']);
      DbManager.db.insertNewFavorite(favorite).then((value) {
        mySnackbarAction('Sitio agregado a Favoritos', context);
      });


  }
}
