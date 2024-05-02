import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/firebase_options.dart';
import 'package:socialapp/src/pages/home_page.dart';
import 'package:socialapp/src/pages/login_page.dart';
import 'package:socialapp/src/providers/main_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return FutureBuilder(
        future: mainProvider.initPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox.square(
                dimension: 150.0, child: Text("Ha ocurrido un error!!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: const Color.fromARGB(255, 47, 62, 70)
                );
          }
          if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade900),
                useMaterial3: true,
              ),
              home: mainProvider.name==""?const LoginPage():const HomePage(),
            );
          }
          return const SizedBox.square(
              dimension: 50.0,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ));
        });
  }
}
