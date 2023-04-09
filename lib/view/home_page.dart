import 'package:appjam_f61/core/components/widgets/widgets.dart';
import 'package:appjam_f61/core/constants/fonts.dart';
import 'package:appjam_f61/core/constants/images.dart';
import 'package:appjam_f61/core/model/questions.dart';
import 'package:appjam_f61/core/responsive/frame_size.dart';
import 'package:appjam_f61/view/question_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/other/build_circular_indicator.dart';
import '../core/utils/config.dart';
import 'package:carousel_slider/carousel_slider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refQuestions = FirebaseDatabase.instance
      .ref()
      .child("questions_table")
      .child("allQuestions");
  var refQuestionsToken = FirebaseDatabase.instance
      .ref()
      .child("questions_table")
      .child(Config.token);

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          appBar: customAppBar(context, false, "Akademiye Danış", true),
          body: Container(
            height: FrameSize.screenHeight,
            width: FrameSize.screenWidth,
            child: Padding(
              padding: const EdgeInsets.all(27.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: FrameSize.screenHeight / 7,
                      width: FrameSize.screenWidth,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff34A853), width: 1.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset(Images.oua_logo1),
                            SizedBox(width: 15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hoşgeldin ${_auth.currentUser!.displayName}",style: TextStyle(fontFamily: themeFontBold,fontSize: 18),),
                                SizedBox(height: 5,),
                                Text("${_auth.currentUser!.email}",style: TextStyle(fontFamily: themeFontRegular,fontSize: 15),),


                              ],
                            )

                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //Text("Akademiye Danış !",style: TextStyle(fontFamily: themeFontBold,fontSize: 25,color: Color(0xff4285F4)),),

                    SingleChildScrollView(
                      child: Container(
                        height: FrameSize.screenHeight / 1.3,
                        child: StreamBuilder<DatabaseEvent>(
                          stream: refQuestions.onValue,
                          builder: (context, event) {
                            if (event.hasData) {
                              var questionList = <Questions>[];

                              var cameValue =
                                  event.data!.snapshot.value as dynamic;

                              if (cameValue != null) {
                                cameValue.forEach((key, nesne) {
                                  var cameValue =
                                      Questions.fromJson(key, nesne);
                                  questionList.add(cameValue);
                                });
                              }
                              if (questionList.length != 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 58.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: questionList.length,
                                    itemBuilder: (context, indeks) {
                                      var question = questionList[indeks];

                                      return GestureDetector(
                                        onTap: () {
                                          Config.questionKey =
                                              question.question_key!;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuestionDetail(
                                                          question: question)));
                                        },
                                        child: Column(
                                          children: [
                                            Card(
                                              color: Color(0xffE6E6E6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Container(
                                                height: 74,
                                                width: FrameSize.screenWidth,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          left: 25,
                                                          right: 15,
                                                          bottom: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          // color: Colors.red,
                                                          width: FrameSize
                                                                  .screenWidth /
                                                              1.9,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                question
                                                                    .question_context!,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .darkBlueThemeClr,
                                                                    fontFamily:
                                                                        themeFontRegular,
                                                                    fontSize:
                                                                        14),
                                                              ),

                                                              SizedBox(
                                                                height: 2,
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    question
                                                                        .question_writer!,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff4285F4),
                                                                        fontFamily:
                                                                            themeFontRegular,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Text(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    " - ${question.question_title!}",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .darkBlueThemeClr,
                                                                        fontFamily:
                                                                            themeFontRegular,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ],
                                                              ),

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
                                                          Icons
                                                              .info_outline_rounded,
                                                          color: AppColors
                                                              .darkBlueThemeClr,
                                                        ),
                                                        onPressed: () {},
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
                              } else {
                                return Center(
                                    child: Text(
                                  "Liste Henüz Boş !",
                                  style: TextStyle(
                                      fontSize: 17, fontFamily: themeFontLight),
                                ));
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
          )),
    );
  }
}
