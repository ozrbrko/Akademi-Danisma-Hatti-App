import 'dart:io';
import 'package:appjam_f61/view/login.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../responsive/frame_size.dart';
import '../../utils/config.dart';

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
        EmailValidator(errorText: 'Lütfen geçerli bir e-posta giriniz !'),
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
        MinLengthValidator(8, errorText: 'Şifre en az 8 basamaklı olmalıdır !')
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

ElevatedButton customElevatedButtonNotFill(String text, Color btnColor, Color textColor,
    double btnRadius, String fontFamily, Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(btnRadius),
              side: BorderSide(color: btnColor, width: 1),

            ),
        )),
    child: Text(
      text,
      style:
      TextStyle(fontFamily: fontFamily, fontSize: 20.0, color: textColor),
    ),
  );
}




AppBar customAppBar(
    BuildContext context, bool backButton, String appText, bool exitButton) {
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
      exitButton
          ? InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Container(
                  width: FrameSize.screenWidth / 6, child: Icon(Icons.exit_to_app)))
          : Container(width: 0, height: 0),
      SizedBox(
        width: 15,
      )
    ],
    backgroundColor: Color(0xffFBBC05),
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


DropdownButtonFormField2 DropdownFormFieldType(
    TextEditingController txtController) {
  return DropdownButtonFormField2(
    decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        filled: true,
        hintText: "Alan Seçiniz",
        hintStyle: TextStyle(
            fontFamily: themeFontLight,
            color: AppColors.greyThemeClr,
            fontSize: 14.0)),
    isExpanded: true,
    hint: Text(
      'Alan Seçiniz',
      style: TextStyle(fontSize: 16),
    ),
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    items: Config.questionTypes
        .map((item) => DropdownMenuItem<String>(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.blackThemeClr,
        ),
      ),
    ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return 'Bu alan zorunludur !';
      }
    },
    onChanged: (value) {
      txtController.text = value!;
    },
    onSaved: (value) {
      selectedValue = value.toString();
      txtController.text = value!;
    },
  );
}

DropdownButtonFormField2 DropdownFormFieldDegree(
    TextEditingController txtController) {
  return DropdownButtonFormField2(
    decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        filled: true,
        hintText: "Zorluk Derecesi",
        hintStyle: TextStyle(
            fontFamily: themeFontLight,
            color: AppColors.greyThemeClr,
            fontSize: 14.0)),
    isExpanded: true,
    hint: Text(
      'Zorluk Derecesi',
      style: TextStyle(fontSize: 16),
    ),
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    items: Config.questionDegree
        .map((item) => DropdownMenuItem<String>(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.blackThemeClr,
        ),
      ),
    ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return 'Bu alan zorunludur !';
      }
    },
    onChanged: (value) {
      txtController.text = value!;
    },
    onSaved: (value) {
      selectedValue = value.toString();
      txtController.text = value!;
    },
  );
}