import 'dart:collection';
import 'package:appjam_f61/core/components/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../core/constants/fonts.dart';
import '../../core/responsive/frame_size.dart';
import '../../core/utils/config.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class AddNewAnswer extends StatefulWidget {
  const AddNewAnswer({Key? key}) : super(key: key);

  @override
  State<AddNewAnswer> createState() => _AddNewAnswerState();
}

class _AddNewAnswerState extends State<AddNewAnswer> {

  TextEditingController  answerContextInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    FrameSize.init(context: context);

    return Scaffold(
      appBar: customAppBar(context, false, "Cevap Ekle",false),
      body: Container(
        height: FrameSize.screenHeight,

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [


                  SizedBox(height: 20,),
                  Text("Çözümünü Paylaş !",style: TextStyle(fontSize: 30,fontFamily: themeFontBold,color: Color(0xff4285F4)),),
                  // Text("Fill in your details to get add.",style: TextStyle(fontSize: 16,fontFamily: themeFontSemiBold,color: AppColors.blackThemeClr),),

                  SizedBox(height: 35,),




                  customTextFormField("Cevap Açıklaması", answerContextInputController, "Bu alan zorunludur!", TextInputType.text, false, "false"),

                  SizedBox(height: 40),

                  SizedBox(
                      width: FrameSize.screenWidth,
                      height: FrameSize.screenHeight / 14,
                      child: customElevatedButtonNotFill("Gönder", Color(0xffFBBC05),Color(0xff4285F4), 17, themeFontBold, () {

                        if (_formKey.currentState!.validate())
                        {
                          print("Validated");
                          var answerContext = answerContextInputController.text;



                          var refAnswers = FirebaseDatabase.instance.ref().child("questions_table").child("allQuestions").child(Config.questionKey!).child("answers");
                          // var refQuestionsToken = FirebaseDatabase.instance.ref().child("questions_table").child(Config.token);


                          var info = HashMap<String,dynamic>();
                          info["answer_context"] = answerContext;
                          info["answer_writer"] = "${_auth.currentUser!.displayName}";
                          info["user_id"] = Config.token;
                          info["answer_key"] = "";




                          refAnswers.push().set(info);
                          // refQuestionsToken.push().set(info); // Kullanıcıların Kendi Sorularını görmesi için


                          return Navigator.pop(context);
                        }
                        else
                        {
                          print("Not Validated");
                        }
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


