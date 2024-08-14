import 'dart:convert';

import 'package:api_tutorial/models/example_three_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

// List<ExampleThreeModel> allList = [];

// Future<List<ExampleThreeModel>> getData() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//   final data = jsonDecode(response.body.toString());
//   if (response.statusCode == 200) {
//     for (Map i in data) {
//       allList.add(ExampleThreeModel(
//           id: i['id'],
//           name: i['name'],
//           username: i['username'],
//           email: i['email'],
//           phone: i['phone'],
//           website: i['website']));
//     }
//     return allList;
//   } else {
//     return allList;
//   }
// }

List<UserModel> userList = [];

Future<List<UserModel>> getUser() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  final data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      userList.add(UserModel.fromJson(i));
    }
    return userList;
  } else {
    return userList;
  }
}

class _ExampleThreeState extends State<ExampleThree> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Three'),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: FutureBuilder(
          //       future: getData(),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Center(child: CircularProgressIndicator());
          //         } else {
          //           return ListView.builder(
          //               itemCount: allList.length,
          //               itemBuilder: (context, index) {
          //                 return Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Card(
          //                     elevation: 0,
          //                     child: ListTile(
          //                       title: Text(allList[index].name.toString()),
          //                     ),
          //                   ),
          //                 );
          //               });
          //         }
          //       }),
          // ),
          Expanded(
            child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                      title: 'Name',
                                      value: userList[index].name.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'UserName',
                                      value:
                                          userList[index].username.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Email',
                                      value: userList[index].email.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Address',
                                      value: userList[index]
                                          .address!
                                          .city
                                          .toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Latitude',
                                      value: userList[index]
                                          .address!
                                          .geo!
                                          .lat
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
