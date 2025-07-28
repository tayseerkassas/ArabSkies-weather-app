import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home_page.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
// import 'login_page.dart';
class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
      Get.snackbar('Success', 'Registered Successfully');

    } catch (e) {
      Get.snackbar('Error', 'Registration Failed');

      Get.snackbar("error", "email or password is missing or wrong input");
    }
  }





  Future<void> registerWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("تم التسجيل بنجاح");
    } catch (e) {
      print("خطأ: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
            color:  Colors.green,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("images/city.jpg"), fit: BoxFit.cover)),
            child: Container(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 45,),
                  Center(
                    child: Image.asset(
                      "images/weather-109.png",
                      width: 210,
                      height: 210,
                    ),
                  ),
                  SizedBox(height: 20,),SizedBox(height: 20,),

                  // Center( child: Image.asset("images/Notely Owl 1.png", width: 120,
                  //   height: 120,)),
                  Container(
                    color: const Color.fromARGB(200, 255, 255, 255),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        child: Column(
                      children: [
                        SizedBox(height: 12,),
                        TextFormField(
                          //controller
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurpleAccent,
                            ),

                            prefixIconColor:Colors.deepPurpleAccent,
                            hintText: "email",
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide(width: 1)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),






                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color:Colors.deepPurpleAccent,
                            ),

                            hintText: "password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.0,
                              ),
                            ),
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide(width: 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.deepPurpleAccent,
                            ),

                            hintText: "Confirm password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.0,
                              ),
                            ),
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide(width: 1)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text("if you have an accont "),
                              InkWell(
                                onTap: () {
                                  Get.to( Login());
                                },
                                child: const Text(
                                  "Click Here",
                                  style: TextStyle(color: Colors.deepPurpleAccent),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: MaterialButton(
                          minWidth: 100,
                          padding: const EdgeInsets.all(15),
                          color: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            // Get.offAll(Home());
                            register();
                          },
                          child: const Text(
                            "Singup",
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
