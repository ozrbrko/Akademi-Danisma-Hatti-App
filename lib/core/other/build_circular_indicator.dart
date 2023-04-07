import 'package:flutter/material.dart';


import '../constants/colors.dart';
import '../constants/fonts.dart';

class BuildCircularIndicatorWidget extends StatelessWidget {
  const BuildCircularIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            // color: ColorsConst.appColor,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Text("loading", style: TextStyle(fontFamily: themeFontSemiBold, color: AppColors.greyThemeClr, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
