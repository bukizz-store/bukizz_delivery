import 'package:bukizz_delivery/mvvm/views/profile/user%20details/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../constants/dimensions.dart';
import '../../../providers/bottom_nav_bar_provider.dart';
import '../../../utils/Widgets/text and textforms/Reusable_text.dart';
import '../NavBar/NavBar.dart';
import 'contact_us.dart';


class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (val){
        context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
        return ;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {context.read<BottomNavigationBarProvider>().setSelectedIndex(0);Navigator.pushNamed(context, MainScreen.route);}, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),),
          title: ReusableText(text: 'Profile', fontSize: 20,fontWeight: FontWeight.w500,)
        ),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: dimensions.height10,),
                Center(
                  child: CircleAvatar(
                    radius:dimensions.height10*5.5,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset('assets/user.svg'),
                  ),
                ),
                SizedBox(height: dimensions.height10,),
                ReusableText(text: 'Sugam ', fontSize: 22,fontWeight: FontWeight.w500,),
                SizedBox(height: dimensions.height10*2,),
                ReusableText(text: 'Sugam@gmail.com' , fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xFF121212).withOpacity(0.6),),
                SizedBox(height: dimensions.height16,),
                ReusableText(text: '', fontSize: 14,fontWeight: FontWeight.w700,color:Color(0xFF121212).withOpacity(0.6)),
                SizedBox(height: dimensions.height10*5,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AddressScreen1.route);
                  },
                  child: Container(
                    height: dimensions.height10*8.5,
                    width: dimensions.screenWidth,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Row(
                               children: [
                                 CircleAvatar(
                                   radius: dimensions.width10*2.5,
                                   backgroundColor: Color(0xFFCCE8FF),
                                   child: Icon(Icons.home,color: Color(0xFF0590FF),),
                                 ),
                                 SizedBox(width: dimensions.height10,),
                                 ReusableText(text: 'Profile',fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFF121212),)
                               ],
                             ),
                            Icon(Icons.chevron_right),
                           ],
                         ),

                      ],
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: (){
                //     // context.read<MyOrders>().fetchOrders();
                //     // Navigator.pushNamed(context, OrderScreen.route);
                //   },
                //   child: Container(
                //     height: dimensions.height10*8.5,
                //     width: dimensions.screenWidth,
                //     color: Colors.white,
                //     padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Row(
                //               children: [
                //                 CircleAvatar(
                //                   radius: dimensions.width10*2.5,
                //                   backgroundColor: Color(0xFFCCE8FF),
                //                   child: Icon(Icons.document_scanner,color: Color(0xFF0590FF),),
                //                 ),
                //                 SizedBox(width: dimensions.height10,),
                //                 ReusableText(text: 'Order History',fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFF121212),)
                //               ],
                //             ),
                //            Icon(Icons.chevron_right),
                //           ],
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: (){Navigator.pushNamed(context, ContactUsScreen.route);},
                  child: Container(
                    height: dimensions.height10*8.5,
                    width: dimensions.screenWidth,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: dimensions.width10*2.5,
                                  backgroundColor: Color(0xFFCCE8FF),
                                  child: Icon(Icons.phone,color: Color(0xFF0590FF),),
                                ),
                                SizedBox(width: dimensions.height10,),
                                ReusableText(text: 'Contact Us',fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFF121212),)
                              ],
                            ),
                             Icon(Icons.chevron_right),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
          child: InkWell(
            onTap: (){
              showCustomAboutDialog(context);
            },
            child: Container(
              width: dimensions.screenWidth,
              height: dimensions.height48,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF058FFF)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.logout,color: Color(0xFF058FFF),),
                  ReusableText(text: 'Logout', fontSize: 16,color:Color(0xFF058FFF),)
                ],
              )
            ),
          )
        ),

      ),
    );
  }

}

void showCustomAboutDialog(BuildContext context) {
  Dimensions dimensions=Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
          title: Center(
            child: Column(
              children: [
                ReusableText(text: 'Are You Sure', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
                SizedBox(height: dimensions.height10*2,),
                ReusableText(text: 'You are about to logout from the app', fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF444444),),
              ],
            ),
          ),
          content:Container(
            // width: dimensions.width10*35.6,
            height: dimensions.height10*8.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                  child: Container(
                    width: dimensions.width10*11.5,
                    height: dimensions.height10*3.5,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: ReusableText(text: 'Logout', fontSize: 14,fontWeight: FontWeight.w600, color: Color(0xFF00579E),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: dimensions.width10*11.5,
                    height: dimensions.height10*3.5,
                    decoration: ShapeDecoration(
                      color: Color(0xFF058FFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: ReusableText(text: 'Cancel', fontSize: 14,fontWeight: FontWeight.w600, color:Colors.white,),
                    ),
                  ),
                )
              ],
            ),
          )

      );

    },
  );
}

