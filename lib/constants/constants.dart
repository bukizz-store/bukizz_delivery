import 'package:bukizz_delivery/utils/Widgets/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

class AppConstants {
  static String fcmToken = '';
  static bool isLogin = false;

  static Future<void> showSnackBar(BuildContext context , String text , Color color , IconData icon , {int time = 2}) async {
    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 25.h,
          left: 10,
          right: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){

        },
        child: Container(
          width: 270,
          // padding: const EdgeInsets.all(16),
          padding: EdgeInsets.only(left: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black54,width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon ,color: Colors.white,size: 24,),
              10.horizontalSpace,
              SizedBox(
                width: 70.w,
                child: Wrap(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
      duration: Duration(seconds: time),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}