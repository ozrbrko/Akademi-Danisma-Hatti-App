import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../core/components/widgets/widgets.dart';
import '../core/constants/colors.dart';
import '../core/constants/fonts.dart';
import '../core/constants/images.dart';
import '../core/responsive/frame_size.dart';
import '../core/services/auth_service.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController surnameInputController = TextEditingController();
  TextEditingController mailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  AuthService _authService = AuthService();

  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);

    return Scaffold(
      appBar: null,
      body: Container(
        height: FrameSize.screenHeight,
        width: FrameSize.screenWidth,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                      height: FrameSize.screenHeight / 3.5,
                      child: Image.asset(Images.oua_hands)),

                  Text(
                    "Kaydol, Bir Bilene Danış !",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: themeFontBold,
                        color: Color(0xff4285F4)),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  customTextFormField("Ad", nameInputController,
                      "name_required", TextInputType.text, false, "false"),
                  SizedBox(
                    height: 20,
                  ),
                  customTextFormField("Soyad", surnameInputController,
                      "surname_required", TextInputType.text, false, "false"),
                  SizedBox(
                    height: 20,
                  ),
                  customTextFormField("E-posta", mailInputController,
                      "email_required", TextInputType.text, false, "mail"),
                  SizedBox(
                    height: 20,
                  ),
                  customTextFormField(
                      "Şifre",
                      passwordInputController,
                      "password_required",
                      TextInputType.text,
                      true,
                      "password"),

                  SizedBox(height: 40),

                  // not: register ->
                  SizedBox(
                      width: FrameSize.screenWidth,
                      height: FrameSize.screenHeight / 14,
                      child: customElevatedButton(
                          "Kayıt Ol",
                          Color(0xffFBBC05),
                          Colors.white,
                          17.0,
                          themeFontBold,
                          () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    print("Validated"),
                                    _authService.register(mailInputController.text.trim(), passwordInputController.text.trim(), nameInputController.text.trim(), surnameInputController.text.trim()).then((value) {

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                                    }).catchError((error) {
                                      if (error is FirebaseAuthException &&
                                          error.code ==
                                              'email-already-in-use') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Bu e-posta adresi zaten kullanılıyor.'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Bir hata oluştu: $error'),
                                          ),
                                        );
                                      }
                                    }),
                                  }
                                else
                                  {
                                    print("Not Validated"),
                                  }
                              })),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Zaten Hesabım Var! ",
                            style: TextStyle(
                                color: AppColors.appThemeClr,
                                fontFamily: themeFontMedium,
                                fontSize: 16)),
                        TextSpan(
                            text: "Giriş Yap",
                            style: TextStyle(
                                color: AppColors.redThemeClr,
                                fontFamily: themeFontMedium,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              }),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
