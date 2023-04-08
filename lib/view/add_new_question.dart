import 'dart:collection';
import 'dart:convert';
import 'package:appjam_f61/core/components/widgets/widgets.dart';
import 'package:appjam_f61/view/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/fonts.dart';
import '../../core/responsive/frame_size.dart';
import '../../core/utils/config.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class AddNewQuestion extends StatefulWidget {
  const AddNewQuestion({Key? key}) : super(key: key);

  @override
  State<AddNewQuestion> createState() => _AddNewQuestionState();
}

class _AddNewQuestionState extends State<AddNewQuestion> {

  TextEditingController  questionTypeInputController = TextEditingController();
  TextEditingController  questionContextInputController = TextEditingController();
  TextEditingController  questionDegreeInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isImage=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isImage=false;
  }

  @override
  Widget build(BuildContext context) {

    FrameSize.init(context: context);

    return Scaffold(
      appBar: customAppBar(context, false, "Soru Ekle",false),
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
                  Text("Problemini Danış !",style: TextStyle(fontSize: 30,fontFamily: themeFontBold,color: Color(0xff4285F4)),),

                  SizedBox(height: 35,),

                  InkWell(
                    onTap: (){
                      pickImage();

                      if(Config.myImage!.isNotEmpty){
                        setState(() {
                          isImage = true;
                        });
                      }
                    },
                    child: SizedBox(
                        width: FrameSize.screenWidth,
                        height: FrameSize.screenHeight / 14,
                        child: Container(


                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                            color: Color(0xffF2F2F2),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                               isImage ? Text("Resim Yüklendi") : Text('Resim Yükle'),
                            ],
                          ),

                        )),
                  ),

                  SizedBox(height: 15,),


                  DropdownFormFieldType(questionTypeInputController),
                  SizedBox(height: 15,),

                  customTextFormField("Soru Açıklaması", questionContextInputController, "Bu alan zorunludur!", TextInputType.text, false, "false"),
                  SizedBox(height: 15,),
                  DropdownFormFieldDegree(questionDegreeInputController),

                  SizedBox(height: 40),

                  SizedBox(
                      width: FrameSize.screenWidth,
                      height: FrameSize.screenHeight / 14,
                      child: customElevatedButtonNotFill("Gönder", Color(0xffFBBC05),Color(0xff4285F4), 17, themeFontBold, () {

                        if (_formKey.currentState!.validate())
                        {
                          print("Validated");
                          var questionType = questionTypeInputController.text;
                          var questionContext = questionContextInputController.text;
                          var questionDegree = questionDegreeInputController.text;



                          var refQuestions = FirebaseDatabase.instance.ref().child("questions_table").child("allQuestions");
                          var refQuestionsToken = FirebaseDatabase.instance.ref().child("questions_table").child(Config.token);


                          var info = HashMap<String,dynamic>();
                            info["question_title"] = questionType;
                            info["question_context"] = questionContext;
                            info["question_degree"] = questionDegree;
                            info["question_writer"] = "${_auth.currentUser!.displayName}";
                            info["user_id"] = Config.token;
                            info["question_key"] = "";
                            info["image"] = Config.myImage;



                          refQuestions.push().set(info);
                          refQuestionsToken.push().set(info); // Kullanıcıların Kendi Sorularını görmesi için


                          return Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
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


Future<void> pickImage() async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pickedFile != null) {

    final bytes = await pickedFile.readAsBytes();
    final imageBytes = bytes.buffer.asUint8List();
    Config.myImage = base64Encode(imageBytes);
  }
}