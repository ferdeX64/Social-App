import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/src/bloc/signup_bloc.dart';
import 'package:socialapp/src/pages/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late SignUpBloc bloc;

  final TextEditingController _emailTextController = TextEditingController();

  @override
  void initState() {
    bloc = SignUpBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final bordersvertical = MediaQuery.of(context).size.height * 4 / 100;
    final bordershorizontal = MediaQuery.of(context).size.width * 6 / 100;
    return Scaffold(
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
                          "Reestablecer contraseña",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
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
                                                  Icons.mail_outlined,
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
                                ],
                              ),
                            )),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: StreamBuilder(
                                stream: bloc.formSignUpStream,
                                builder: (context, snapshot) {
                                  return MaterialButton(
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: _emailTextController.text);
                                      showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                                  title: const Text('Exito'),
                                                  content: const Text(
                                                      'Revisa tu correo electrónico para reestablecer tu contraseña.'),
                                                  actions: <Widget>[
                                                    // ignore: deprecated_member_use
                                                    TextButton(
                                                      
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginPage()));
                                                        },
                                                        child: const Text('Ok'))
                                                  ],
                                                ));
                                    },
                                    height: 50,
                                    // margin: EdgeInsets.symmetric(horizontal: 50),
                                    color: Colors.orange[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    // decoration: BoxDecoration(
                                    // ),
                                    child: const Center(
                                      child: Text(
                                        "Enviar link de reestablecimiento",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                })),
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
    );
  }
}
