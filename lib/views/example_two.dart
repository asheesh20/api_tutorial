import 'dart:convert';

import 'package:api_tutorial/models/example_two_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> allPhotos = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    print(response);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        allPhotos.add(Photos(title: i['title'], url: i['url'], id: i['id']));
      }
      return allPhotos;
    } else {
      Get.snackbar('Error', 'status.code!=200');
      return allPhotos;
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Two'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: allPhotos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      allPhotos[index].url.toString()),
                                ),
                                title: Text(allPhotos[index].id.toString()),
                                subtitle:
                                    Text(allPhotos[index].title.toString()),
                              ),
                            );
                          }),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
