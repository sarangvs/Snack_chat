import 'package:chat_app/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserLocalDatasource {
  Future<void> registerUser(UserModel user);
  Future<UserModel?> loginUser(String email, String password);
  Future<void> init();
}

@LazySingleton(as: UserLocalDatasource)
class UserLocalDatasourceImpl implements UserLocalDatasource {
  late Database db;

  @override
  Future<void> init() async {
    db = await openDatabase(
      'app.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT,
            mobile TEXT,
            country TEXT
          )
        ''');
      },
    );
    print("✅ DB initialized");
  }

  @override
  Future<void> registerUser(UserModel user) async {
    final existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user.email],
    );

    if (existingUser.isNotEmpty) {
      throw Exception("User with this email already exists");
    }

    try {
      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await printAllUsers(); // ✅ Await this
    } catch (e) {
      print("Insert error: $e");
    }
  }

  @override
  Future<UserModel?> loginUser(String email, String password) async {
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<void> printAllUsers() async {
    final result = await db.query('users');
    print("----- All Registered Users -----");
    for (var row in result) {
      print(row);
    }
  }
}
