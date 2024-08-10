import 'package:calculator/modules/archeive_taks/archieve_tasks.dart';
import 'package:calculator/modules/done_tasks/done_tasks.dart';
import 'package:calculator/modules/tasks/tasks.dart';
import 'package:calculator/shared/constant.dart';
import 'package:calculator/shared/shared_login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    createDatabase();
    // getDataFromDatabase(database);
  }

  var controllerName = TextEditingController();
  var controllerTime = TextEditingController();
  var controllerDate = TextEditingController();
  var iconBottomChange = Icons.edit;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var keyForm = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  Database? database;
  List<Widget> list = [
    const Tasks(),
    const DoneTasks(),
    const ArcheiveTasks(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // insertToDatabase();
          if (isBottomSheetShown) {
            if (keyForm.currentState!.validate()) {
              await insertToDatabase(
                title: controllerName.text,
                time: controllerTime.text,
                date: controllerDate.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState(() {
                    tasks = value;
                    isBottomSheetShown = false;
                    iconBottomChange = Icons.edit;
                  });
                  print(tasks.length);
                });
              }).catchError(() {});
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                  (context) => Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: keyForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textForm(
                            onTap: () {
                              print('tapped');
                            },
                            secureText: false,
                            function: () {},
                            text: 'task name',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter task name';
                              }
                              return null;
                            },
                            prefixIcon: Icons.add,
                            controller: controllerName,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textForm(
                            isClickable: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                // print(value);
                                controllerTime.text =
                                    value!.format(context).toString();
                                String date = value.format(context);
                                print(date);
                              });
                            },
                            secureText: false,
                            function: () {},
                            text: 'task time',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter task time';
                              }
                              return null;
                            },
                            prefixIcon: Icons.wallet_giftcard_outlined,
                            controller: controllerTime,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textForm(
                            isClickable: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2025-12-30'),
                              ).then((value) {
                                // print(value);

                                controllerDate.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            secureText: false,
                            function: () {},
                            text: 'date time',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter task date';
                              }
                              return null;
                            },
                            prefixIcon: Icons.date_range_outlined,
                            controller: controllerDate,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //   customeButton(
                          //     text: "Task added",
                          //     width: double.infinity,
                          //     function: () {
                          //       if (keyForm.currentState!.validate()) {
                          //         print("object");
                          //       }
                          //     },
                          //     color: Colors.black,
                          //   )
                        ],
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              isBottomSheetShown = false;
              setState(() {
                iconBottomChange = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              iconBottomChange = Icons.add;
            });
          }
        },
        child: Icon(iconBottomChange),
      ),
      appBar: AppBar(
        title: const Text(
          'Todo App',
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
              ),
              label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_rounded,
              ),
              label: 'archive'),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : list[currentIndex],
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database!.transaction((txn) async {
      txn.rawInsert('''
      INSERT INTO tasks(task_name, task_data, task_time, task_status) 
      VALUES("$title", "$time", "$date", "New taks 4")
    ''').then((value) {
        print("inserted succussefully $value");
      }).catchError((error) {
        print("error $error ");
      });
    });
  }

  void createDatabase() async {
    // Get the path to the database
    // final databasePath = await getDatabasesPath();

    // Open the database and create the table
    database = await openDatabase(
      'todo_app',
      onCreate: (db, version) async {
        // Create a table
        print("database created successfully");

        await db
            .execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          task_name TEXT,
          task_data TEXT,
          task_time TEXT,
          task_status TEXT
        )
      ''')
            .then((value) {
              print("table created successfully");
            })
            .catchError((error) {
              print(error);
            })
            .then((value) => null)
            .catchError((error) {
              print(error);
            });
      },
      version: 1,
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value;
          });
          print(tasks.length);
        });
        print("database opened $database");
      },
    ).catchError((error) {
      print(error);
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    // return 'Hady gamal';
    return await database!.rawQuery('SELECT * FROM tasks');
    // print(tasks[1]['task_name']);/
  }
}
