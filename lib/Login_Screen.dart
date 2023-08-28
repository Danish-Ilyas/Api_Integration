import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 void login(String email ,password)async{
   try{
      Response response =await post(
       Uri.parse('https://reqres.in/api/register'),
       body:{
         'email': email,
         'password': password,
     }
     );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
      }else{
        print('Error');
      }
   } catch(e){
      print(e.toString());
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              login(emailController.text.toString() ,passwordController.text.toString());
            },
               child: Text(' LogIn ')),
          ],
        ),
      ),
    );
  }
}
