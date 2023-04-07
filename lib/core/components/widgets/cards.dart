import 'package:appjam_f61/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import '../../responsive/frame_size.dart';

Widget my_theme_card(TextFormField textFormFieldUserName,TextFormField textFormFieldPassword, {Function()? onPressed,var cardColor, var width,var height,}) {

  return  Card(

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20))),

    color: cardColor,
    child: SizedBox(
      width: FrameSize.screenWidth,
      height: FrameSize.screenHeight / 2,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(FrameSize.screenWidth/11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


              textFormFieldUserName,
              textFormFieldPassword,

              Center(
                child: SizedBox(
                  height: FrameSize.screenHeight/18,
                  width: FrameSize.screenWidth/2.8,
                  child: ElevatedButton(
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(color: Colors.white,fontSize: 19,fontFamily: themeFontBold),
                    ),
                    style: ElevatedButton.styleFrom(

                        primary: Colors.yellow,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // side: BorderSide(color: Colors.red),
                        )),
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}

