import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableBookMark = 'book_mark';
final String columnId = 'Id';
final String columnBookId = 'BookId';
final String columnChapterId = 'ChapterId';
final String columnChapterName = 'ChapterName';
final String columnAddTime = 'AddTime';
final String columnDesc = 'Desc';

class BookMark {
  int id;
  int bookId;
  int chapterId;
  String chapterName;
  String addTime;
  String desc;

  static BookMark fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookMark bookMark = BookMark();
    bookMark.id = map['Id'];
    bookMark.bookId = map['BookId'];
    bookMark.chapterId = map['ChapterId'];
    bookMark.chapterName = map['ChapterName'] ?? "";
    bookMark.addTime = map['AddTime'] ?? "";
    bookMark.desc = map['Desc'] ?? "";
    return bookMark;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnBookId: bookId,
      columnChapterId: chapterId,
      columnChapterName: chapterName,
      columnAddTime: addTime,
      columnDesc: desc,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class BookMarkSqlite {
  Database db;

  openSqlite() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'book_mark.db');

//根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableBookMark (
            $columnId INTEGER PRIMARY KEY, 
            $columnBookId INTEGER,
            $columnChapterId INTEGER, 
            $columnChapterName TEXT, 
            $columnAddTime TEXT, 
            $columnDesc TEXT)
          ''');
    });
  }

// 插入一条书签数据
  Future<int> insert(BookMark bookMark) async {
    await this.openSqlite();
    return await db.insert(tableBookMark, bookMark.toMap());
  }

// 查询所有书签信息
  Future<List<BookMark>> queryAll() async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBookMark, columns: [
      columnId,
      columnBookId,
      columnChapterId,
      columnChapterName,
      columnAddTime,
      columnDesc,
    ]);

    if (maps == null || maps.length == 0) {
      return null;
    }

    List<BookMark> bookMarks = [];
    for (int i = 0; i < maps.length; i++) {
      bookMarks.add(BookMark.fromMap(maps[i]));
    }
    return bookMarks;
  }

//  根据一本书id查询这本书的书签
  Future<List<BookMark>> queryByBookId(int bookId) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBookMark,
        columns: [
          columnId,
          columnBookId,
          columnChapterId,
          columnChapterName,
          columnAddTime,
          columnDesc,
        ],
        where: '$columnBookId = ?',
        whereArgs: [bookId]);

    if (maps == null || maps.length == 0) {
      return null;
    }

    List<BookMark> bookMarks = [];
    for (int i = 0; i < maps.length; i++) {
      bookMarks.add(BookMark.fromMap(maps[i]));
    }
    return bookMarks;
  }

  //  根据章节id查询这章是否有书签
  Future<bool> queryBookMarkIsAdd(int chapterId) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBookMark,
        columns: [
          columnId,
          columnBookId,
          columnChapterId,
          columnChapterName,
          columnAddTime,
          columnDesc,
        ],
        where: '$columnChapterId = ?',
        whereArgs: [chapterId]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }

  // 根据章节id删除书签
  Future<int> deleteByChapterId(int chapterId) async {
    await this.openSqlite();
    return await db.delete(tableBookMark,
        where: '$columnChapterId = ?', whereArgs: [chapterId]);
  }

  // 删除书签
  Future<int> delete(int id) async {
    await this.openSqlite();
    return await db
        .delete(tableBookMark, where: '$columnId = ?', whereArgs: [id]);
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
  }
}
