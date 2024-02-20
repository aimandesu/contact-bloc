import 'package:contact_bloc/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contact_list.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contact(id INT PRIMARY KEY, email TEXT, first_name TEXT, last_name TEXT, avatar TEXT, favourite INT)',
        );
      },
      version: 1,
    );
  }

  Future<List<UserModel>> contactList() async {
    final db = await Db().initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('contact');
    return List.generate(maps.length, (index) {
      return UserModel(
        id: maps[index]["id"],
        email: maps[index]["email"],
        firstname: maps[index]["first_name"],
        lastname: maps[index]["last_name"],
        avatar: maps[index]["avatar"],
        favorite: maps[index]["favourite"],
      );
    });
  }

  Future<void> initializeContact(List<dynamic> contact) async {
    final db = await Db().initializeDB();
    for (UserModel element in contact) {
      final data = UserModel(
        id: element.id,
        email: element.email,
        firstname: element.firstname,
        lastname: element.lastname,
        avatar: element.avatar,
        favorite: 0,
      );
      await db.insert(
        'contact',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> deleteContact(int id) async {
    final db = await Db().initializeDB();
    await db.delete(
      'contact',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateContact(UserModel contact) async {
    final db = await Db().initializeDB();
    await db.update(
      'contact',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModel>> searchContact(String query) async {
    List<UserModel> maps = [];
    final List<UserModel> contact = await contactList();
    for (var element in contact) {
      if (element.firstname.toLowerCase().contains(query.toLowerCase()) &&
          query != "") {
        maps.add(element);
      }
    }
    return List.generate(maps.length, (index) {
      return UserModel(
        id: maps[index].id,
        email: maps[index].email,
        firstname: maps[index].firstname,
        lastname: maps[index].lastname,
        avatar: maps[index].avatar,
        favorite: maps[index].favorite,
      );
    });
  }
}
