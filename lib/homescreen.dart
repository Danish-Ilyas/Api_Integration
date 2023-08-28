import 'package:flutter/material.dart';

import 'dart:convert';


import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var data ;
  Future<void> getUserApi ()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }
    else{
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
        Expanded(child: FutureBuilder(
      future: getUserApi (),
         builder: (context,  snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                return Card(
                  child: Column(
                    children: [
                    Reuseablerow(title: 'Name', value: data[index]['name'].toString(),),
                    Reuseablerow(title: 'Geo', value: data[index]['address']['geo'].toString()),
                    ],
                  ),
                );
              });
        }

         },

    ),
        )],
      ),
    );
  }
}


class Reuseablerow extends StatelessWidget {
  String title , value ;
  Reuseablerow({Key? key,required this.title,required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
