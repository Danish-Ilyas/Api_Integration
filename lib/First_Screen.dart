import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/PostModel.dart';

import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  List<PostModel> postlist = [];


  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postlist.clear();
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    }else {
      print(postlist);

      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Expanded(
           child: FutureBuilder(
             future: getPostApi(),
               builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return Center(child: CircularProgressIndicator(color:Colors.blue));
                 }else{
                   return ListView.builder(
                       itemCount: postlist.length,
                       itemBuilder: (context, index) {
                     return Text(postlist[index].title.toString());
                   });
                 }
               }),
         )
        ],
      ),
    );
  }
}
