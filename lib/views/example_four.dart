import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

var data;
Future<void> getUserData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
  } else {
    Get.snackbar('Error', 'Could not fetch data');
  }
}

class _ExampleFourState extends State<ExampleFour> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Four'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Card(
                              child: Column(
                                children: [
                                  ResuableRow(
                                    title: 'Name',
                                    value: data[index]['name'].toString(),
                                  ),
                                  ResuableRow(
                                    title: 'Email',
                                    value: data[index]['email'].toString(),
                                  ),
                                  ResuableRow(
                                    title: 'Address',
                                    value: data[index]['address']['city']
                                        .toString(),
                                  ),
                                  ResuableRow(
                                    title: 'Latitude',
                                    value: data[index]['address']['geo']['lat']
                                        .toString(),
                                  ),
                                  ResuableRow(
                                    title: 'Longitude',
                                    value: data[index]['address']['geo']['lng']
                                        .toString(),
                                  ),
                                ],
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

class ResuableRow extends StatelessWidget {
  const ResuableRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
