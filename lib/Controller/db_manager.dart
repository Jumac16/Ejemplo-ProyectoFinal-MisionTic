import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import './/Models/favorite_model.dart';

class DbManager{
  static late Database _database;
  final String _databaseName = 'PaisajeandoColombia.db';

  DbManager._();
  static final DbManager db = DbManager._();
  var initialize = false;

  Future<Database> get database async{
    if(!initialize){
      _database = await initDB();
      initialize = true;
    }
    return _database;
  }

  final String _createtableFavorites =
      "CREATE TABLE favorites(name String PRIMARY KEY, city String, state String, description String, image String)";

  initDB() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path, version: 2,
        onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute(_createtableFavorites);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async{}
    );
  }

  Future<int> insertNewFavorite(Favorite favorite) async{
    final db = await database;
    var response = await db.insert('favorites', favorite.toJson());
    return response;
  }

  Future<int> deleteFavorite(Favorite favorite) async{
    final db = await database;
    var response = await db.rawDelete("DELETE FROM favorites WHERE name =?",[favorite.name.toString()]);
    return response;
  }

  Future<List<Favorite>> favoritesList() async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM favorites");
    List<Favorite> favorites = [];
    if(response.isNotEmpty){
      List<Map<String, dynamic>> listTemp = response.toList();
      for (Map<String, dynamic> lt in listTemp){
        favorites.add(Favorite.fromJson(lt));
      }
    }
    return favorites;
  }

}