import 'package:crud_using_sqlite/service/Userservice.dart';
import 'package:flutter/material.dart';

import 'models/User.dart';

class add_user_page extends StatefulWidget {
  const add_user_page({super.key});

  @override
  State<add_user_page> createState() => _add_user_pageState();
}

class _add_user_pageState extends State<add_user_page> {
  var _usernameController = TextEditingController();
  var _usercontactController = TextEditingController();
  var _useraddressController = TextEditingController();

  bool _validatename = false;
  bool _validatecontact = false;
  bool _validateaddress = false;

  var _userservice = UserService();

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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                errorText: _validatename ? 'name can\'t be empty' : null,
                border: const OutlineInputBorder(),
                labelText: 'Name',
                labelStyle: const TextStyle(
                  color: Colors.teal,
                ),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _usercontactController,
              decoration: InputDecoration(
                errorText: _validatecontact ? 'conatact can\'t be empty' : null,
                border: const OutlineInputBorder(),
                labelText: 'Contact',
                labelStyle: const TextStyle(
                  color: Colors.teal,
                ),
                hintText: 'Enter Contact no',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _useraddressController,
              decoration: InputDecoration(
                errorText: _validateaddress ? 'address can\'t be empty' : null,
                border: const OutlineInputBorder(),
                labelText: 'address',
                labelStyle: const TextStyle(
                  color: Colors.teal,
                ),
                hintText: 'Enter Your address',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _usernameController.text.isEmpty
                            ? _validatename = true
                            : _validatename = false;
                        _usercontactController.text.isEmpty
                            ? _validatecontact = true
                            : _validatecontact = false;
                        _useraddressController.text.isEmpty
                            ? _validateaddress = true
                            : _validateaddress = false;
                      });

                      if (_validatename == false &&
                          _validatecontact == false &&
                          _validateaddress == false) {
                        var _user = User();

                        _user.name = _usernameController.text;
                        _user.contact = _usercontactController.text;
                        _user.address = _useraddressController.text;

                        var result = await _userservice.Saveuser(_user);
                        Navigator.of(context).pop(result);
                      }
                      ;
                    },
                    child: const Text(
                      'save details',
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _usernameController.text = '';
                      _usercontactController.text = '';
                      _useraddressController.text = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Clear details',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
