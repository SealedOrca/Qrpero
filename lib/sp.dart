import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DataManager {
  late Database _historyDatabase;
  late Database _favoritesDatabase;
  final Uuid _uuid = const Uuid();

  DataManager._privateConstructor();

  static final DataManager instance = DataManager._privateConstructor();

  Future<void> initializeDatabases() async {
    final databasesPath = await getDatabasesPath();
    final historyPath = join(databasesPath, 'history_database.db');
    final favoritesPath = join(databasesPath, 'favorites_database.db');

    _historyDatabase = await openDatabase(historyPath, version: 1, onCreate: _createHistoryTable);
    _favoritesDatabase = await openDatabase(favoritesPath, version: 2, onCreate: _createFavoritesTable, onUpgrade: _updateFavoritesTable);
  }


  Future<void> _createHistoryTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE HistoryTable (
        id INTEGER PRIMARY KEY,
        uniqueId TEXT,
        data TEXT
      )
    ''');
  }

  Future<void> _createFavoritesTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FavoritesTable (
        id INTEGER PRIMARY KEY,
        uniqueIdReference TEXT,
        data TEXT
      )
    ''');
  }

  Future<void> _updateFavoritesTable(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE FavoritesTable ADD COLUMN uniqueIdReference TEXT');
    }
  }

  String generateUniqueId() {
    return _uuid.v4();
  }

  Future<void> addToHistory(String data) async {
    final uniqueId = generateUniqueId();
    await _historyDatabase.insert('HistoryTable', {'uniqueId': uniqueId, 'data': data});
  }

  Future<void> addToFavorites(String uniqueId, String data) async {
    await _favoritesDatabase.insert('FavoritesTable', {
      'uniqueIdReference': uniqueId,
      'data': data,
    });
  }
  Future<void> removeFromHistory(String uniqueId) async {
    await _historyDatabase.delete(
      'HistoryTable',
      where: 'uniqueId = ?',
      whereArgs: [uniqueId],
    );
  }

  Future<void> removeFromFavorites(String uniqueIdReference) async {
    await _favoritesDatabase.delete(
      'FavoritesTable',
      where: 'uniqueIdReference = ?',
      whereArgs: [uniqueIdReference],
    );
  }

  Future<List<Map<String, dynamic>>?> getHistoryItems() async {
    final List<Map<String, dynamic>> historyMaps = await _historyDatabase.query('HistoryTable');
    return historyMaps;
  }

  Future<List<Map<String, dynamic>>?> getFavoriteItems() async {
    final List<Map<String, dynamic>> favoriteMaps = await _favoritesDatabase.query('FavoritesTable');
    return favoriteMaps;
  }

  Future<bool> isFavorite(String uniqueIdReference) async {
    final favoriteItems = await getFavoriteItems();
    return favoriteItems!.any((item) => item['uniqueIdReference'] == uniqueIdReference);
  }

  Future<void> toggleFavorite(String uniqueId) async {
    final isFav = await isFavorite(uniqueId);
    if (isFav) {
      await removeFromFavorites(uniqueId);
    } else {
      final historyItem = await readData(uniqueId);
      if (historyItem != null) {
        final uniqueIdReference = historyItem['uniqueId'] as String;
        final data = historyItem['data'] as String;
        await addToFavorites(uniqueIdReference, data);
      }
    }
  }

  // Additional methods remain the same

  Future<List<Map<String, dynamic>>?> retrieveAllData() async {
    final List<Map<String, dynamic>> allDataMaps = await _historyDatabase.query('HistoryTable');
    return allDataMaps;
  }

  Future<void> saveData(String barcodeResult) async {
    await addToHistory(barcodeResult);
  }

  Future<void> deleteData(String uniqueId) async {
    await removeFromHistory(uniqueId);
  }

  Future<Map<String, dynamic>?> readData(String uniqueId) async {
    final List<Map<String, dynamic>>? historyMaps = await getHistoryItems();
    for (var map in historyMaps!) {
      if (map['uniqueId'] == uniqueId) {
        return map;
      }
    }
    return null;
  }

  Future<void> deleteAllData() async {
    await _historyDatabase.delete('HistoryTable');
  }

  Future<List<Map<String, dynamic>>?> retrieveFavoriteData() async {
    final List<Map<String, dynamic>>? favoriteMaps = await getFavoriteItems();
    return favoriteMaps;
  }
}
