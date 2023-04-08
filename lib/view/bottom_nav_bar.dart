import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:appjam_f61/view/home_page.dart';
import 'package:appjam_f61/view/my_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_new_question.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
     //const RegisterPage(),
    const HomePage(),
    const AddNewQuestion(),
    const MyQuestions(),


    //const Login(),
     //const RegisterPage(),

    // const RegisterPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        pageController: _pageController,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.black87,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 1',


          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.add,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.add,
              color: Colors.white,
            ),
            itemLabel: 'Page 2',
          ),

          ///svg example
          BottomBarItem(
            inActiveItem: Icon(
              Icons.question_answer_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.question_answer_outlined,
              color: Colors.white,
            ),
            itemLabel: 'Page 3',
          ),

        ],
        onTap: (index) {
          /// control your animation using page controller
          _pageController.jumpToPage(index);

        },
      )
          : null,
    );
  }
}
