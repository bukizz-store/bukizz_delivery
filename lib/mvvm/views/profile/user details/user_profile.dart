
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/font_family.dart';
import '../../../../constants/dimensions.dart';
import '../../../../utils/Widgets/buttons/Reusable_Button.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_text.dart';


class AddressScreen1 extends StatefulWidget {
  static const String  route = '/address';
  const AddressScreen1({super.key});

  @override
  State<AddressScreen1> createState() => _AddressScreen1State();
}

class _AddressScreen1State extends State<AddressScreen1> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  void initState() {
    super.initState();
    // _nameController.text = AppConstants.userData.name ?? '';
    // _emailController.text = AppConstants.userData.email ?? '';
    // _phoneController.text = AppConstants.userData.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),),
        title: ReusableText(text:'Profile',fontSize:20,fontWeight: FontWeight.w500,),
      ),
      body: Column(
        children: [
          SizedBox(height: dimensions.height24,),

          //full name
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              controller: _nameController,
              decoration:InputDecoration(
                labelText: 'Full Name *',
                labelStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),

              ),
            ),
          ),

          SizedBox(height: dimensions.height24,),
          //phone no
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters:[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
              decoration:InputDecoration(
                labelText: 'Phone Number *',
                labelStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
              ),
            ),
          ),
          SizedBox(height: dimensions.height24,),
          //email
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              enabled: false,
              decoration:InputDecoration(
                labelStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6)
                ),
                labelText: 'Email Address *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
              ),
            ),
          ),
          SizedBox(height: dimensions.height24/3,),
          // TextButton(onPressed: (){
          //
          // }, child: ReusableText(text: 'Save Changes', fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xFF00579E),)),
          SizedBox(height: dimensions.height24/2,),
          //address
          Container(
            width: dimensions.screenWidth,
            height: dimensions.height8*12,
            // color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width16,vertical: dimensions.height8*1.5),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Address
                          ReusableText(text: 'Address', fontSize: 16),

                          SizedBox(height: dimensions.height8*2,),
                          // address with overflow
                          Container(
                            width: dimensions.width24 * 9.5,
                            child: ReusableText(
                              text: "123 street ",
                              fontSize: 14,
                              height: 0,
                              color: Color(0xFF7A7A7A),
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nunito,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),

                    ]
                )
            ),
          ),


        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.width9),
        child: ReusableElevatedButton(
            width: dimensions.width342,
            height: dimensions.height10 * 5.4,
            onPressed: () {

            },
            buttonText: 'Save Changes'
        ),
      ),
    );
  }
}
