import 'package:bukizz_delivery/constants/dimensions.dart';
import 'package:bukizz_delivery/utils/Widgets/buttons/Reusable_Button.dart';
import 'package:bukizz_delivery/utils/Widgets/spacing/spacing.dart';
import 'package:bukizz_delivery/utils/Widgets/tick_screen/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_text.dart';


class ViewDetailScreen extends StatefulWidget {
  static const route = '/View Details';
  const ViewDetailScreen({super.key});

  @override
  State<ViewDetailScreen> createState() => _ViewDetailScreenState();
}

class _ViewDetailScreenState extends State<ViewDetailScreen> {
  bool isTrue=false;
  TextEditingController _otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            15.verticalSpace,
            Container(
              // margin: EdgeInsets.only(bottom: dimensions.width24),
              padding: EdgeInsets.symmetric(horizontal: dimensions.width10*2,vertical: dimensions.height10*2),
              color: Colors.white,
              width: dimensions.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(text: '#123445', fontSize: 16,fontWeight: FontWeight.w700,),
                      Column(
                        children: [
                          ReusableText(text: 'Amount', fontSize: 12,color: AppColors.lightTextColor,),
                          20.verticalSpace,
                          ReusableText(text: '₹ 22hc', fontSize: 16)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: dimensions.height10*1.2,),
                  SizedBox(
                    width: dimensions.width10*19,
                    child: const Text(
                      'Dr. Vscc Sharda Nagar',
                      style: TextStyle(
                        color: Color(0xFF121212),
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: dimensions.height10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: 'Status:', fontSize: 12,color: AppColors.lightTextColor,fontWeight: FontWeight.w400,),
                      SizedBox(width: 4,),
                      ReusableText(text: '', fontSize: 12,color: Color(0xFF058FFF),)
                    ],
                  ),

                ],
              ),

            ),
            Container(
              width: dimensions.screenWidth,
              height: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
            Container(
              width: dimensions.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: dimensions.width10*2,vertical: dimensions.height10*2),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(text: 'Invoice', fontSize: 20,fontWeight: FontWeight.w700),
                      GestureDetector(
                        onTap: ()async{
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PDFViewer()));
                        },
                        child: Container(
                          width: 30.w,
                          height: 24.sp,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReusableText(text: 'Call', fontSize: 14,color: AppColors.buttonColor,),
                              Icon(Icons.phone, color: AppColors.buttonColor,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  SizedBox(
                    width: dimensions.width10*34.5,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'SHIP TO  \n',
                            style: TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: '1234 mf vsmvsjvm',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Price (2 items)', fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.lightTextColor,),
                          ReusableText(text: '₹ 1222', fontSize: 12,fontWeight: FontWeight.w500,)
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Discount', fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.lightTextColor,),
                          ReusableText(text: '- ₹1000', fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.green),
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Delivery Charges', fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.lightTextColor,),
                          ReusableText(text: '₹ 22020', fontSize: 12,fontWeight: FontWeight.w500,)
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Total Amount', fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.lightTextColor,),
                          ReusableText(text: '₹ 30', fontSize: 12,fontWeight: FontWeight.w500,)
                        ],
                      ),


                    ],
                  )
                ],
              ),
            ),

            50.verticalSpace,

            Container(
              width: 60.sp,
              height: 20.sp,
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 6) {
                    return 'Enter a 6-digit OTP';
                  }
                  return null;
                },
              ),
            ),

            20.verticalSpace,

            ReusableElevatedButton(
                width: 65.sp,
                height: 27.sp,
                onPressed: (){
                  //if otp is true
                  setState(() {
                    isTrue=true;
                  });
                },
                buttonText: 'Validate OTP'
            ),
            100.verticalSpace,
            if(isTrue)
            SwipeButton(
                width: 75.sp,
                thumb: Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                child: Text(
                  "Swipe to confirm delivery",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                activeThumbColor: AppColors.buttonColor,
                activeTrackColor: Colors.grey.shade300,

                onSwipe: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Delivered"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TickScreen(text: 'Order Delivered Sucessfully', secondaryText: 'Go to home screen to deliver more')));

                },
              )

          ],

        ),
      ),
    );
  }
}
