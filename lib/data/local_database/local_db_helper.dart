import '../models/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  static final LocalDbHelper _instance = LocalDbHelper.internal();
  factory LocalDbHelper() => _instance;
  LocalDbHelper.internal();
  static late Database _db;

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'articles.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'create table articles(id integer primary key autoincrement,title varchar(255),description varchar(255),url varchar(255),urlToImage varchar(255),publishedAt varchar(255))');
    });
    return _db;
  }

  Future<int> saveArticle(Article article) async {
    Database db = await createDatabase();
    return await db.insert('articles', article.toJson());
  }

  Future<List> allSavedArticles() async {
    Database db = await createDatabase();
    return await db.query('articles');
  }

  Future<int> delete(int articleId) async {
    Database db = await createDatabase();

    return await db.delete('articles', where: 'id = ?', whereArgs: [articleId]);
  }
}
