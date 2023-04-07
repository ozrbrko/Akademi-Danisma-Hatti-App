import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<User?> logIn(String email, String password, BuildContext context) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    // logger.e("user ${user}");
    return user.user;
  }


  logOut() async{
    return await _auth.signOut();
  }

  Future<User?> register(String email, String password, String name, String surname) async{

    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    user.user!.updateDisplayName("${name} ${surname}");

    // addUser(email, password, name, surname);



    return user.user;
  }

}