import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();

  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDb();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppKeys.dbTable} (
        ${TaskKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TaskKeys.title} TEXT,
        ${TaskKeys.note} TEXT,
        ${TaskKeys.date} TEXT,
        ${TaskKeys.time} TEXT,
        ${TaskKeys.category} TEXT,
        ${TaskKeys.isCompleted} INTEGER
      )
    ''');
  }

  /// Adds dummy tasks for demonstration purposes
  Future<void> insertDummyData() async {
    final db = await database;

    final List<Map<String, dynamic>> dummyTasks = [
      {
        TaskKeys.title: "Morning Yoga",
        TaskKeys.note: "Start at 6:30 AM",
        TaskKeys.date: "Jan 18, 2025",
        TaskKeys.time: "6:30 AM",
        TaskKeys.category: TaskCategory.health.name,
        TaskKeys.isCompleted: true,
      },
      {
        TaskKeys.title: "Team Lunch",
        TaskKeys.note: "At the new Italian restaurant",
        TaskKeys.date: "Jan 19, 2025",
        TaskKeys.time: "1:00 PM",
        TaskKeys.category: TaskCategory.social.name,
        TaskKeys.isCompleted: true,
      },
      {
        TaskKeys.title: "Meeting with John",
        TaskKeys.note: "Discuss project updates and timelines.",
        TaskKeys.date: "Jan 12, 2025",
        TaskKeys.time: "10:00 AM",
        TaskKeys.category: TaskCategory.work,
        TaskKeys.isCompleted: false,
      },
      {
        TaskKeys.title: "Grocery Shopping",
        TaskKeys.note: "Buy vegetables, milk, and bread.",
        TaskKeys.date: "Jan 13, 2025",
        TaskKeys.time: "5:00 PM",
        TaskKeys.category: TaskCategory.personal,
        TaskKeys.isCompleted: false,
      },
      {
        TaskKeys.title: "Team Meeting",
        TaskKeys.note: "Weekly sync-up with the team.",
        TaskKeys.date: "Jan 05, 2025",
        TaskKeys.time: "2:00 PM",
        TaskKeys.category: TaskCategory.work,
        TaskKeys.isCompleted: true,
      },
      {
        TaskKeys.title: "Family Dinner",
        TaskKeys.note: "Dinner at Mom's house.",
        TaskKeys.date: "Jan 26, 2025",
        TaskKeys.time: "7:00 PM",
        TaskKeys.category: TaskCategory.home,
        TaskKeys.isCompleted: false,
      }
    ];

    for (final task in dummyTasks) {
      await db.insert(AppKeys.dbTable, task);
    }
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        AppKeys.dbTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(
      maps.length,
      (index) {
        return Task.fromJson(maps[index]);
      },
    );
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        AppKeys.dbTable,
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          AppKeys.dbTable,
          where: 'id = ?',
          whereArgs: [task.id],
        );
      },
    );
  }
}
