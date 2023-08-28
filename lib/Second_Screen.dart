import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/photo_model.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<PhotoModel> photosList = [];

  Future<List<PhotoModel>> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      photosList.clear();
      for (var i in data) {
        final photos = PhotoModel(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      throw Exception('Failed to fetch photos');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder<List<PhotoModel>>(
            future: getPhotos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image(image: NetworkImage(snapshot.data![index].url.toString()),),
                        //title: Text(snapshot.data![index].title.toString()),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Container(); // Placeholder for other states if necessary
              }
            },
          ),
        ],
      ),
    );
  }
}
