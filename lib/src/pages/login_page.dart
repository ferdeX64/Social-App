import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/src/pages/home_page.dart';
import 'package:socialapp/src/pages/reset_password.dart';
import 'package:socialapp/src/pages/signin_page.dart';
import 'package:socialapp/src/providers/main_provider.dart';

import '../bloc/signup_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SignUpBloc bloc;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool _passwordVisible = false;
  bool _getUsername = false;
  @override
  void initState() {
    bloc = SignUpBloc();

    super.initState();

    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final bordersvertical = MediaQuery.of(context).size.height * 4 / 100;
    final bordershorizontal = MediaQuery.of(context).size.width * 6 / 100;
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    late Map<String, dynamic> content = {};
    mainProvider.intro = false;
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topRight, colors: [
              Colors.blue.shade900,
              Colors.black,
              Colors.orange.shade900
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/pro.png',
                              height: 70,
                              width: 70,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text(
                            "Inicio de sesión",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: const Text(
                            "Bienvenido a MarketBoost Pro",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: bordersvertical),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: bordershorizontal),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1400),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.shade100,
                                          blurRadius: 20,
                                          offset: const Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade200))),
                                      child: StreamBuilder(
                                          stream: bloc.emailStream,
                                          builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) =>
                                              TextField(
                                                onChanged: bloc.changeEmail,
                                                textAlign: TextAlign.start,
                                                controller: _emailTextController,
                                                cursorColor: Colors.blue,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.9)),
                                                decoration: InputDecoration(
                                                  errorStyle: const TextStyle(
                                                      color: Colors.red),
                                                  errorText:
                                                      snapshot.error?.toString(),
                                                  prefixIcon: const Icon(
                                                    Icons.mail_outline,
                                                    color: Colors.black,
                                                  ),
                                                  labelText: "Ingresa tu email",
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black),
                                                  filled: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior.never,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.3),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade200))),
                                      child: StreamBuilder(
                                          stream: bloc.passwordStream,
                                          builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) =>
                                              TextField(
                                                textAlign: TextAlign.start,
                                                onChanged: bloc.changePassword,
                                                controller:
                                                    _passwordTextController,
                                                obscureText: !_passwordVisible,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                cursorColor: Colors.black,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                  errorStyle: const TextStyle(
                                                      color: Colors.red),
                                                  errorText:
                                                      snapshot.error?.toString(),
                                                  prefixIcon: const Icon(
                                                    Icons.lock_outline,
                                                    color: Colors.black,
                                                  ),
                                                  labelText:
                                                      "Ingresa tu contraseña",
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      _passwordVisible
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                  filled: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior.never,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.3),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none)),
                                                ),
                                                keyboardType:
                                                    TextInputType.visiblePassword,
                                              )),
                                    ),
                                  ],
                                ),
                              )),
                               FadeInUp(
                                duration: const Duration(milliseconds: 1600),
                                 child: Center(
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ResetPasswordPage()));
    
                                            },
                                            child: const Text(
                                              "¿Olvidaste tu contraseña?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                               ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: StreamBuilder(
                                  stream: bloc.formSignUpStream,
                                  builder: (context, snapshot) {
                                    return MaterialButton(
                                      onPressed: () {
                                        _getUsername=true;
                                        setState(() {
                                          
                                        });
                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: _emailTextController.text,
                                                password:
                                                    _passwordTextController.text)
                                            .then((value) {
                                          var user =
                                              FirebaseAuth.instance.currentUser;
                                          String token;
                                          user?.getIdTokenResult().then((result) {
                                            token = result.token!;
                                            mainProvider.token = token;
                                            
                                            content = JwtDecoder.decode(token);
                                            
                                            mainProvider.name=content['name'];
                                            if(mainProvider.name.isNotEmpty){
                                                _getUsername=false;
                                                Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                                
                                            }
                                            
                                            
                                          });
                                          
                                          
                                        }).onError((error, stackTrace) {
                                          _getUsername=false;
                                          
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                surfaceTintColor: Colors.white,
                                                    title: const Text('Alerta'),
                                                    content: const Text(
                                                        'El email o la contraseña son incorrectos.'),
                                                    actions: <Widget>[
                                                      // ignore: deprecated_member_use
                                                      TextButton(
                                                          style: TextButton.styleFrom(
                                                              foregroundColor:
                                                                 const Color(
                                                                      0xFFCB2B93)),
                                                          onPressed: () {
                                                            _getUsername=false;
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text('Ok'))
                                                    ],
                                                  ));
                                        });
                                      },
                                      height: 50,
                                      // margin: EdgeInsets.symmetric(horizontal: 50),
                                      color: Colors.orange[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      // decoration: BoxDecoration(
                                      // ),
                                      
                                      child:  Center(
                                        child:_getUsername? const SizedBox(height: 23,width: 23,
                                          child:  Center(child:  CircularProgressIndicator(color: Colors.white,))):const Text(
                                          "Iniciar sesión",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  })),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const SigninPage()));
                                },
                                height: 50,
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // decoration: BoxDecoration(
                                // ),
                                child: const Center(
                                  child: Text(
                                    "Registrate",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1700),
                              child: const Text(
                                "Publica en tu red social favorita con un click",
                                style: TextStyle(color: Colors.grey),
                              )),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FadeInUp(
                                    duration: const Duration(milliseconds: 1900),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/fb.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: FadeInUp(
                                    duration: const Duration(milliseconds: 1900),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/tiktok.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: FadeInUp(
                                    duration: const Duration(milliseconds: 1900),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/insta.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
