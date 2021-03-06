import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../core/location_model.dart';

class LocationDatabase {
  final String id = 'id';
  final String tablename = 'locationTable';
  final String dateTime = 'dateTime';
  final String latitude = 'latitude';
  final String longitude = 'longitude';
  final String prevlatitude = 'prevlatitude';
  final String prevlongitude = 'prevlongitude';
  final String prevdatetime = 'prevdateTime';

  LocationDatabase._privateConstructor();

  static final LocationDatabase instance =
      LocationDatabase._privateConstructor();

  Database _db;

  Future<Database> get getdb async {
    if (_db != null) {
      return _db;
    }
    _db = await _createNewDatabase();
    return _db;
  }

  Future<Database> _createNewDatabase() async {
    String path = join(await getDatabasesPath(), 'locationdatabase.db');
    return await openDatabase(path, version: 1, onCreate: _onDatabaseCreate);
  }

  _onDatabaseCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tablename(
      $id INTEGER PRIMARY KEY,
      $dateTime STRING NOT NULL,
      $latitude REAL NOT NULL,
      $longitude REAL NOT NULL,
      $prevlatitude REAL,
      $prevlongitude REAL,
      $prevdatetime STRING 
    )''');
  }

  Future<List<Map<String, dynamic>>> retriveLocationDb() async {
    Database db = await instance.getdb;
    List<Map<String, dynamic>> results = await db.query(tablename);
    return results;
    // return List.generate(
    //   results.length,
    //   (index) {
    //     return LocationModel(
    //       id: results[index][id],
    //       dateTime: DateTime.parse(results[index][dateTime]),
    //       latitude: results[index][latitude],
    //       longitude: results[index][longitude],
    //       prevlatitude: results[index][prevlatitude],
    //       prevlongitude: results[index][prevlongitude],
    //       prevdateTime: DateTime.parse(results[index][prevdatetime]),
    //     );
    //   },
    // );
  }

  Future<List<Map<String, dynamic>>> retrivePrevData(int insertid) async {
    Database db = await instance.getdb;
    if (insertid != null) {
      List<Map<String, dynamic>> rawResult = await db.query(tablename,
          columns: [dateTime, latitude, longitude],
          where: '$id=?',
          whereArgs: [insertid]);
      print('RAW: $rawResult');
      return rawResult;
    }
    return null;
  }

  Future<int> insertLocationDb(LocationModel newLocation) async {
    print("Inserting in locationdb");
    Database db = await instance.getdb;
    return db.insert(
      tablename,
      newLocation.toMap(),
    );
  }

  Future<int> deleteLocationDb(LocationModel location) async {
    Database db = await instance.getdb;
    return db.delete(tablename, where: "id=?", whereArgs: [location.id]);
  }
}

// This is the example of how ti create multiple table in SQLITE
// onDatabaseCreate(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE $bucketTable(
//       $bucketid INTEGER PRIMARY KEY,
//       $item STRING NOT NULL,
//       $isdone INTEGER
//     )''');
//     await db.execute('''
//     CREATE TABLE $tablename(
//       $id INTEGER PRIMARY KEY,
//       $productname STRING NOT NULL,
//       $date STRING NOT NULL,
//       $price REAL NOT NULL,
//       $status INTEGER NOT NULL,
//       $description INTEGER,
//       $imagepath String,
//       $category String
//     )''');
//   }
