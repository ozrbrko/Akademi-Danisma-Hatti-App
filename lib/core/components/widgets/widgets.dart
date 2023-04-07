import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../responsive/frame_size.dart';

List<File> imageList = [];
List<String> imageListPath = [];
String? selectedValue;

TextFormField customTextFormField(
    String hinttext,
    TextEditingController txtcontroller,
    String required,
    TextInputType textType,
    bool obscure,
    String forValidation) {
  if (forValidation == "mail") {
    return TextFormField(
      controller: txtcontroller,
      onSaved: (deger) => txtcontroller.text = deger!,
      keyboardType: textType,

      // key: key1,

      validator: MultiValidator([
        RequiredValidator(errorText: required),
        EmailValidator(errorText: 'valid_email_address'),
      ]),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 32),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
          filled: true,
          // fillColor: Colors.white,
          hintText: hinttext,
          hintStyle: TextStyle(
              fontFamily: themeFontLight,
              color: AppColors.greyThemeClr,
              fontSize: 16.0)),

      obscureText: obscure,
    );
  } else if (forValidation == "password") {
    return TextFormField(
      controller: txtcontroller,
      onSaved: (deger) => txtcontroller.text = deger!,
      keyboardType: textType,

      // key: key1,

      validator: MultiValidator([
        RequiredValidator(errorText: required),
        MinLengthValidator(8, errorText: 'password_must')
      ]),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 32),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
          filled: true,
          // fillColor: Colors.white,
          hintText: hinttext,
          hintStyle: TextStyle(
              fontFamily: themeFontLight,
              color: AppColors.greyThemeClr,
              fontSize: 16.0)),

      obscureText: obscure,
    );
  } else {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: txtcontroller,
      onSaved: (deger) => txtcontroller.text = deger!,
      keyboardType: textType,

      // key: key1,

      validator: MultiValidator([
        RequiredValidator(errorText: required),
      ]),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 32),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(
              fontFamily: themeFontLight,
              color: AppColors.greyThemeClr,
              fontSize: 16.0)),



      obscureText: obscure,
    );
  }
}





ElevatedButton customElevatedButton(String text, Color btnColor, Color textColor,
    double btnRadius, String fontFamily, Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(btnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius),
        ))),
    child: Text(
      text,
      style:
          TextStyle(fontFamily: fontFamily, fontSize: 20.0, color: textColor),
    ),
  );
}





AppBar customAppBar(
    BuildContext context, bool backButton, String appText, bool profileIcon) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    centerTitle: true,
    title: Text(
      appText,
      style: TextStyle(
          color: AppColors.whiteThemeClr,
          letterSpacing: 1,
          fontFamily: themeFontRegular),
    ),
    actions: [
      profileIcon
          ? InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Container(
                  width: FrameSize.screenWidth / 6, child: Icon(Icons.person)))
          : Container(width: 0, height: 0),
      SizedBox(
        width: 15,
      )
    ],
    backgroundColor: AppColors.appThemeClr,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
    ),
  );
}

TextFormField ContentTextFormField(
    TextEditingController txtcntrller, String required, String textHint) {
  return TextFormField(
    controller: txtcntrller,
    validator: MultiValidator([
      RequiredValidator(errorText: required),
    ]),
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 32),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        filled: true,
        hintText: textHint,
        hintStyle: TextStyle(
            fontFamily: themeFontLight,
            color: AppColors.greyThemeClr,
            fontSize: 16.0)),


  );
}
