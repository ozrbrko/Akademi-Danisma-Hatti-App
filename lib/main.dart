import 'package:appjam_f61/view/bottom_nav_bar.dart';
import 'package:appjam_f61/view/login.dart';
import 'package:appjam_f61/view/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akademi Danışma Hattı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//
//   var refTest = FirebaseDatabase.instance.ref().child("test");
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     var bilgi = HashMap<String,dynamic>();
//
//     bilgi["mesaj"] = "merhaba";
//     refTest.push().set(bilgi);
//   }
//
//
//   int _counter = 0;
//
//
// }


