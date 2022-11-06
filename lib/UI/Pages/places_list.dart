import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/main_menu.dart';
import 'place_view.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      drawer: mainMenu(context),
      body: placesBody()
    );
  }

  myAppbar() {
    return AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      title: const Text('Lugares', style: TextStyle(color: Colors.white),),
    );
  }

  placesBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("sitios-turisticos").snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError) {return const Text('Un Error Ha Ocurrido!', style: TextStyle(fontSize: 18, color: Colors.red),);}
        if(!snapshot.hasData) return const Text('Cargando Información');
          return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              itemCount: snapshot.data!.docs.length * 2,
              itemBuilder: (context, index){
                if(index.isOdd) return const Divider();
                int indexsite = index ~/ 2;
                QueryDocumentSnapshot site = snapshot.data!.docs[indexsite];
                return myItem(site);
              }
          );
        }
    );
  }


myItem(QueryDocumentSnapshot site) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceView(site))
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red,),
      title: Text(site['Nombre'], style: const TextStyle(fontSize: 20, color: Colors.red),),
      subtitle: Text('${site['Ciudad']}, ${site['Departamento']}', style: const TextStyle(fontSize: 18),),
    );
  }
}
