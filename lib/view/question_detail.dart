import 'dart:convert';
import 'package:appjam_f61/core/components/widgets/widgets.dart';
import 'package:appjam_f61/core/constants/fonts.dart';
import 'package:appjam_f61/core/model/answers.dart';
import 'package:appjam_f61/core/model/questions.dart';
import 'package:appjam_f61/view/add_new_answer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/other/build_circular_indicator.dart';
import '../core/responsive/frame_size.dart';
import '../core/utils/config.dart';

class QuestionDetail extends StatefulWidget {

  Questions? question;
  QuestionDetail({this.question});

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  var refAnswers = FirebaseDatabase.instance.ref().child("questions_table").child("allQuestions").child(Config.questionKey!).child("answers");

  void initState() {
    super.initState();
    Config.questionKey = widget.question!.question_key!;
    print(Config.questionKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: customAppBar(context, true, "Soru Detay", false),

        body: Container(

          height: FrameSize.screenHeight,
          width: FrameSize.screenWidth,

          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: SizedBox(
                      height: FrameSize.screenHeight/2.3,
                      width: FrameSize.screenWidth,

                      child: Image.memory(
                        base64Decode(widget.question!.imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(child: Text("Açıklama: ${widget.question!.question_context}",style: TextStyle(fontSize: 17,fontFamily: themeFontMedium),))
                    ],
                  ),
                  SizedBox(height: 10,),

                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cevaplar",
                        style: TextStyle(
                            fontFamily: themeFontSemiBold, fontSize: 22),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewAnswer()));
                          },
                          child: Icon(
                            Icons.add_box,
                            color: Color(0xff34A853),
                            size: 40,
                          )),
                    ],
                  ),

                  SingleChildScrollView(

                    child: Container(
                      height: FrameSize.screenHeight/1.3,
                      child: StreamBuilder<DatabaseEvent>(
                        stream: refAnswers.onValue,
                        builder: (context, event) {
                          if (event.hasData) {
                            var answerList = <Answers>[];

                            var cameValue = event.data!.snapshot.value as dynamic;

                            if (cameValue != null) {
                              cameValue.forEach((key, nesne) {
                                var cameValue = Answers.fromJson(key, nesne);
                                answerList.add(cameValue);
                              });
                            }
                            if(answerList.length!=0){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 58.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: answerList.length,
                                  itemBuilder: (context, indeks) {

                                    var answer = answerList[indeks];


                                    return GestureDetector(
                                      onTap: () {
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Color(0xffE6E6E6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              height: 74,
                                              width: FrameSize.screenWidth,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 8.0,left: 25,right: 15,bottom: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Center(
                                                      child: Container(
                                                        // color: Colors.red,
                                                        width: FrameSize.screenWidth/1.9,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [

                                                            Text(
                                                              overflow: TextOverflow.ellipsis,
                                                              answer.answer_context!,
                                                              style: TextStyle(color: Color(0xff4285F4),fontFamily: themeFontBold,fontSize: 16),
                                                            ),

                                                            SizedBox(height: 2,),


                                                            // Text(
                                                            //   overflow: TextOverflow.ellipsis,
                                                            //   question.question_context!,
                                                            //   style: TextStyle(color: AppColors.appThemeClr,fontFamily: themeFontRegular,fontSize: 14),
                                                            // ),
                                                            SizedBox(height: 2,),

                                                            // Text(
                                                            //   overflow: TextOverflow.ellipsis,
                                                            //   question.question_title!,
                                                            //   style: TextStyle(color: AppColors.appThemeClr,fontFamily: themeFontLight,fontSize: 13),
                                                            // ),





                                                            // SizedBox(
                                                            //   height: 50,
                                                            //   width: 150,
                                                            //   child: Image.memory(
                                                            //     base64Decode(question.imageFile!), // base64 verisini çözümleme işlemi
                                                            //     fit: BoxFit.cover,
                                                            //   ),
                                                            // ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.info_outline_rounded,
                                                        color: AppColors.appThemeClr,
                                                      ),

                                                      onPressed: () {
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else{
                              return  Center(child: Text("there_is_no",style: TextStyle(fontSize: 17,fontFamily: themeFontLight),));
                            }

                          } else {
                            return BuildCircularIndicatorWidget();
                          }
                        },
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),


        ));
  }
}
