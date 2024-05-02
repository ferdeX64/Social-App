import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:socialapp/src/pages/add_video_page.dart';
import 'package:socialapp/src/pages/login_page.dart';
import 'package:socialapp/src/providers/main_provider.dart';
import 'package:socialapp/src/widgets/video_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text("Todos los videos",
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 47, 62, 70)),
          drawer: Drawer(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                        top: 80, right: 50, left: 50, bottom: 20),
                    child: const Icon(
                      size: 100,
                      Icons.person_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Bienvenido "),
                        Text(
                          mainProvider.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        
                        mainProvider.name = "";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      });
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text("Cerrar Sesión"),
                  ),
                ],
              ),
            ),
          ),
          body: const VideoList(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddVideoPage()));
            },
            tooltip: 'Increment',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        onWillPop: () => exit(0));
  }
}
