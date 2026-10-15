import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearnFirstore(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LearnFirstore extends StatefulWidget {
  const new({super.key});

  @override
  State<LearnFirstore> createState() => _LearnFirstoreState();
}

class _LearnFirstoreState extends State<LearnFirstore> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // to send the data

  Future<void> sendData() async {
    final firstore = FirebaseFirestore.instance;

    try {
      await firstore.collection("employ").add({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("the data is sumitted")));
    } catch (e) {
      print("failed");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something went wrong")));

      throw Exception("noting worked right now");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 54, 25),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    Text(
                      "Registration Page",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "password",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        sendData();
                      },

                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text("submit"),
                    ),

                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
