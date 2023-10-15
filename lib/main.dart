import 'package:crud_using_sqlite/edituser.dart';
import 'package:crud_using_sqlite/service/Userservice.dart';
import 'package:crud_using_sqlite/viewuser.dart';
import 'package:flutter/material.dart';

import 'add_user_page.dart';
import 'models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(add_user_page()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(result, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList;
  var userId = User().id;
  final _userservice = UserService();

  getAlldata() async {
    var users = await _userservice.readuser();
    _userList = <User>[];

    users.forEach((users) {
      var userModel = User();
      userModel.id = users['id'];
      userModel.name = users['name'];
      userModel.contact = users['contact'];
      userModel.address = users['address'];

      _userList.add(userModel);
    });
  }

  @override
  void initState() {
    getAlldata();
    super.initState();
  }

  _showsuccesssnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _deleteFromDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text('Are you sure you want to delete ?'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  var result = await _userservice.deleteUser(userId);
                  if (result != null) {
                    Navigator.pop(context, result);
                    getAlldata();
                    _showsuccesssnackbar('user details Deleted');
                  }
                },
                child: Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SQLite CRUD',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Viewuser(user: _userList[index])));
                },
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                title: Text(
                  _userList[index].name ?? '',
                ),
                subtitle: Text(_userList[index].contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditUser(user: _userList[index])))
                              .then((data) {
                            if (data != null) {
                              getAlldata();
                              _showsuccesssnackbar('user details Updated');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFromDialog(context, _userList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const add_user_page()))
              .then((data) {
            if (data != null) {
              getAlldata();
              _showsuccesssnackbar('user details added');
            }
          });
        },
        elevation: 5,
        child: const Icon(Icons.add),
      ),
    );
  }
}
