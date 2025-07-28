import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'singup.dart';
import 'package:http/http.dart' as http;
import 'pages/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Get.defaultDialog(
          title: "error", middleText: "your email or password not exist");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.green,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("images/weather-109.jpg"), fit: BoxFit.cover)),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "images/weather-109.png",
                      width: 225,
                      height: 225,
                    ),
                  ),

                  SizedBox(height: 20,),
                  // Center( child: Image.asset("images/Notely Owl 1.png", width: 120,
                  //   height: 120,)),
                  SizedBox(height: 5,),
                  Container(
                    color: Color.fromARGB(200, 255, 255, 255),
                    padding: EdgeInsets.all(20),
                    child: Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurpleAccent,
                            ),

                            prefixIconColor: Colors.deepPurpleAccent,
                            hintText: "email",
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide(width: 1)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.deepPurpleAccent,
                            ),

                            hintText: "password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.0,
                              ),
                            ),
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide(width: 1)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("if you don't have an accont "),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (_) => Singup ()));
                                },

                                child: Text(
                                  "Click Here",
                                  style: TextStyle(color: Colors.deepPurpleAccent),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: MaterialButton(
                          minWidth: 100,
                          padding: EdgeInsets.all(15),
                          color: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          onPressed: () {

                            onPressed: login();



                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        ))
                      ],
                    )),
                  )
                ],
              ),
            )));
  }
}
