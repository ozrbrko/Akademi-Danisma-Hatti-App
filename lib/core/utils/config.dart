import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';


class Config {

  static bool _loading = false;
  static String token = '';
  static String displayName = '';
  static String key ="";
  static String? selectedValue;
  static String? myImage;
  static String? questionKey;
  static bool? page;


  static Future <Widget> loading() async{
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
        height: 26.0,
        width: 26.0,
      ),
    );
  }

  static String generateRandomId() {
    final random = Random.secure();
    return random.nextInt(100000000).toString();
  }

  static String utf8FormatText(String text) {
    return utf8.decode(text.codeUnits).toString();
  }

  static String toUtf8(String text) {
    var encodedText = utf8.encode(text);
    return utf8.decode(encodedText);
  }


  static List<String> questionTypes = [
    'Flutter',
    'Unity',

  ];

  static List<String> questionDegree = [
    '1',
    '2',
    '3',
    '4',

  ];


}