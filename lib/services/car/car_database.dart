import 'package:sqflite/sqflite.dart';
import '../../pages/car/car_model.dart';

class CarsDatabase {
  static const String _databaseName = 'cars.db';
  static const int _databaseVersion = 1;

  static Database? _database;

  static Future<Database?> get database async {
    _database ??= await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _database;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE cars ('
        'mnCarId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'szCarMarke TEXT,'
        'szCarModel TEXT,'
        'szCarKennzeichen TEXT,'
        'szcarFahrgestellnummer TEXT,'
        'szCarZulassungsbesitzer TEXT,'
        'szCarErstzulassung TEXT,'
        'crateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
        ')');
  }

  //List all Cars
  static Future<List<CarModel>> getAllCars() async {
    final db = await database;
    final cars = await db!.query('cars');
    return cars.map((car) => CarModel.fromMap(car)).toList();
  }

  //Get Car by Id
  static Future<CarModel?> getCarById(int mnCarId) async {
    final db = await database;
    final car =
        await db!.query('cars', where: 'mnCarId = ?', whereArgs: [mnCarId]);
    return car.isEmpty ? null : CarModel.fromMap(car.first);
  }

  //Insert Car
  static Future<int> insertCar(CarModel car) async {
    final db = await database;
    return await db!.insert('cars', car.toMap());
  }

  //Update Car
  static Future<int> updateCar(CarModel car) async {
    final db = await database;
    return await db!.update('cars', car.toMap(),
        where: 'mnCarId = ?', whereArgs: [car.mnCarId]);
  }

  //Delete Car
  static Future<int> deleteCar(int mnCarId) async {
    final db = await database;
    return await db!.delete('cars', where: 'mnCarId = ?', whereArgs: [mnCarId]);
  }
}
