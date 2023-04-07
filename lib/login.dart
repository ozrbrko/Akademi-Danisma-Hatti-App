import 'package:appjam_f61/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'core/components/widgets/widgets.dart';
import 'core/constants/fonts.dart';
import 'core/constants/images.dart';
import 'core/responsive/frame_size.dart';
import 'core/services/auth_service.dart';
import 'core/utils/config.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController loginInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  AuthService _authService = AuthService();

  bool _obscureText = true;
  bool? _loading = false;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);

    return Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Container(
            height: FrameSize.screenHeight,
            width: FrameSize.screenWidth,
            color: Color(0xffF2F2F2),

            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [

                  SizedBox(
                      height: FrameSize.screenHeight/2.5,
                      child: Image.asset(Images.oua_logo)),


                  Text("Akademi Danışma Hattı !",style: TextStyle(fontSize: 25,fontFamily: themeFontBold,color: Color(0xff4285F4)),),

                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        // Login Card View
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 21.0,
                            ),
                          ],
                        ),

                        // **********   GİRİŞ YAP CARD VIEW WİDGET  **********
                        child:  Form(
                          key: _formKey,
                          child: Card(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),

                            color: Colors.white,
                            child: SizedBox(
                              width: FrameSize.screenWidth,
                              height: FrameSize.screenHeight / 2,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(FrameSize.screenWidth/11),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [

                                        SizedBox(height: 15,),

                                        customTextFormField("E-posta", loginInputController, "E-posta zorunludur!", TextInputType.text, false, "mail"),
                                        SizedBox(height: 20,),
                                        customTextFormField("Şifre", passwordInputController, "Şifre zorunludur!", TextInputType.text, false, "password"),


                                        SizedBox(height: 30,),

                                        SizedBox(
                                          width: FrameSize.screenWidth,
                                          height: FrameSize.screenHeight/14.5,
                                          child: customElevatedButton("Giriş Yap", Color(0xffFBBC05), Colors.white, 17, themeFontBold, () {
                                            if (_formKey.currentState!.validate())
                                            {
                                              print("Validated");
                                            _authService.logIn(loginInputController.text.trim(), passwordInputController.text, context).then((value) {
                                            // logger.e("döndü ${value}");
                                            Config.token = value!.uid;
                                            // Config.secureStorage.savePreferences(value!.uid);
                                            // logger.i("token ${Config.token}");
                                              print("Config token: ${Config.token}");
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));


                                            }).catchError((error) => {
                                            ScaffoldMessenger.of(
                                            context)
                                                .showSnackBar(
                                            SnackBar(
                                            content: Text(
                                            "E-posta veya şifre hatalı!"),
                                            ))
                                            });
                                            }
                                            else
                                            {
                                            print("Not Validated");
                                            }
                                          })),

                                      SizedBox(height: 20,),

                                      RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "Hala Hesabın Yok Mu? ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: themeFontMedium,
                                                  fontSize: 16)),
                                          TextSpan(
                                              text: "Kayıt Ol",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: themeFontMedium,
                                                  fontSize: 16),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                                                  // Navigator.pushNamed(context, '/register');
                                                  // logger.i("Register tıklandı.");
                                                }),
                                        ]),
                                      ),

                                    ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
