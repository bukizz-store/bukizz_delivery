import 'package:bukizz_delivery/constants/constants.dart';
import 'package:bukizz_delivery/constants/dimensions.dart';
import 'package:bukizz_delivery/mvvm/viewModels/orders/orders.dart';
import 'package:bukizz_delivery/mvvm/views/NavBar_Screens/Delivery/View_details.dart';
import 'package:bukizz_delivery/mvvm/views/profile/contact_us.dart';
import 'package:bukizz_delivery/utils/Widgets/spacing/spacing.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/Widgets/dialog box/OtpDialogueBox.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_text.dart';

class Delivery_Screen extends StatefulWidget {
  static const route = '/delivery';
  const Delivery_Screen({super.key});

  @override
  State<Delivery_Screen> createState() => _Delivery_ScreenState();
}

class _Delivery_ScreenState extends State<Delivery_Screen> {
  Future<Position?> getCurrentLocation() async {
    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return null; // Permissions not granted
        }
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  void getLocationAndNavigate() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      // Navigate using obtained location
      double latitude = position.latitude;
      double longitude = position.longitude;
      navigateToLocation(latitude, longitude);
    }
  }

  Future<void> navigateToLocation(double latitude, double longitude) async {
    // Construct the addresses list with destination locations
    List<String> addresses = [
      'Sector+15+Gurugram',
      'Sector+16+Gurugram',
      'Sector+17+Gurugram',
      //todo Give Plus sign instead of address
    ];

    String url = 'https://www.google.com/maps/dir/';

    // Adding the source location to the URL
    url += '$latitude,$longitude/';

    // Adding the destinations to the URL
    for (int i = 0; i < addresses.length; i++) {
      if (i != 0) {
        url += '/';
      }
      url += addresses[i];
    }

    Uri mapUrl = Uri.parse(url);
    await launchUrl(mapUrl);
  }

  Future<void> navigate(String address) async {
    // Construct the addresses list with destination locations
    Position? position = await getCurrentLocation();
    if (position != null) {
      // Navigate using obtained location
      double latitude = position.latitude;
      double longitude = position.longitude;
      navigateToLocation(latitude, longitude);

      String url = 'https://www.google.com/maps/dir/';

      // Adding the source location to the URL
      url += '$latitude,$longitude/$address';

      Uri mapUrl = Uri.parse(url);
      await launchUrl(mapUrl);
    }
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return Consumer<Orders>(builder: (context, orders, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.numbers),
          title: ReusableText(
            text: 'My Delivery',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                SizedBox(
                  width: dimensions.width10 * 34.5,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Facing any issue? Feel free to call our',
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontSize: 12,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Color(0xFF00579E),
                            fontSize: 12,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Customer Service',
                          style: TextStyle(
                            color: Color(0xFF00579E),
                            fontSize: 12,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle onTap event here
                              Navigator.pushNamed(
                                  context, ContactUsScreen.route);
                            },
                        ),
                        TextSpan(
                          text: ' for assitance',
                          style: TextStyle(
                            color: Color(0xFF444444),
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
                Container(
                  width: 50.w,
                  height: 28.sp,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5FAFF),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0.50,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF00579E),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    width: 60.w,
                    height: 10.h,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF5FAFF),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF00579E),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true, // Add this line
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(right: 2.w),
                              width: 23.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                  color: selectedIndex != index
                                      ? Colors.transparent
                                      : AppColors.tabcolor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: ReusableText(
                                text: index == 0 ? 'Undelivered' : 'Delivered',
                                fontSize: 12,
                                color: selectedIndex != index
                                    ? AppColors.forgotPasswordTextColor
                                    : AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                20.verticalSpace,
                GestureDetector(
                  onTap: () {
                    navigate(orders.listAddress);
                  },
                  child: Container(
                      width: 50.sp,
                      height: 30.sp,
                      decoration: BoxDecoration(
                        color: AppColors.tabcolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            ReusableText(
                              text: 'Navigate All',
                              fontSize: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )),
                ),
                20.verticalSpace,
                selectedIndex == 0
                    ? Container(
                        height: orders.pendingOrders.length * 80.sp,
                        child: ListView.builder(
                            itemCount: orders.pendingOrders.length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.only(
                                    left: 10, top: 15, right: 10, bottom: 15),
                                width: dimensions.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Icon(Icons
                                                  .qr_code_scanner_outlined),
                                              width: 25.sp,
                                              height: 25.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                            15.horizontalSpace,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                    text:
                                                        'Order ID: ${orders.pendingOrders[index].orderId.split('-')[0]}',
                                                    fontSize: 14),
                                                5.verticalSpace,
                                                SizedBox(
                                                  width:52.sp,
                                                  child: Text(
                                                        'Recipient: ${orders.pendingOrders[index].address.name}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'nunito'
                                                    ),
                                                    //overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap:(){
                                            Navigator.pushNamed(context, ViewDetailScreen.route);
                                          },
                                          child: Container(
                                            width: 40.sp,
                                            height: 26.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: ReusableText(
                                                text: 'View Details',
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    25.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Icon(
                                                  Icons.location_on_outlined),
                                              width: 25.sp,
                                              height: 25.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                // border: Border.all(color: Colors.black26)
                                              ),
                                            ),
                                            15.horizontalSpace,
                                            Container(
                                              width: 35.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ReusableText(
                                                      text: 'Address:',
                                                      fontSize: 16),
                                                  10.verticalSpace,
                                                  Text(
                                                    orders.pendingOrders[index]
                                                        .address
                                                        .toString(),
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            navigate(orders.pendingOrders[index].address.toNavigateString());


                                          },
                                          child: Container(
                                            width: 40.sp,
                                            height: 26.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: ReusableText(
                                                text: 'Navigate',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    25.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async{
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return OTPDialog(
                                                  onOTPConfirmed: (String otp) {
                                                    //getting the otp from firebase database as it stores in ordersOTP -> orderId:OTP and comparing with otp entered by user
                                                    FirebaseDatabase.instance.ref().child('ordersOTP').get().then((value) => value.children.forEach((element) async {
                                                      if(element.key == orders.pendingOrders[index].orderId){
                                                        if(element.value == otp){
                                                          await orders.updateOrderStatus(
                                                              orders.pendingOrders[index],
                                                              'Delivered');
                                                          //delete this otp from database
                                                          await FirebaseDatabase.instance.ref().child('ordersOTP').child(orders.pendingOrders[index].orderId).remove();
                                                        }
                                                        else{
                                                          AppConstants.showSnackBar(context, "Invalid OTP", Colors.grey, Icons.error_outline_rounded);
                                                        }
                                                      }
                                                    }));
                                                  },
                                                );
                                              },
                                            );

                                          },
                                          child: Container(
                                            width: 36.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.tabcolor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                                child: ReusableText(
                                              text: 'Delivered',
                                              fontSize: 16,
                                              color: Colors.white,
                                            )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            orders.updateOrderStatus(
                                                orders.pendingOrders[index],
                                                'Redelivery');
                                          },
                                          child: Container(
                                            width: 36.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                                child: ReusableText(
                                              text: 'Not Delivered',
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    : Container(
                        height: orders.deliveredOrders.length * 65.sp,
                        child: ListView.builder(
                            itemCount: orders.deliveredOrders.length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.only(
                                    left: 10, top: 15, right: 10, bottom: 15),
                                width: dimensions.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Icon(Icons
                                                  .qr_code_scanner_outlined),
                                              width: 25.sp,
                                              height: 25.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                // border: Border.all()
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                    text:
                                                        'Order ID: ${orders.deliveredOrders[index].orderId.split('-')[0]}',
                                                    fontSize: 14
                                                ),
                                                5.verticalSpace,
                                                SizedBox(
                                                  width:52.sp,
                                                  child: Text(
                                                    'Recipient: ${orders.deliveredOrders[index].address.name}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: 'nunito'
                                                    ),
                                                    //overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 40.sp,
                                          height: 26.sp,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: ReusableText(
                                              text: 'View Details',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    25.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Icon(
                                                  Icons.location_on_outlined),
                                              width: 25.sp,
                                              height: 25.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                // border: Border.all(color: Colors.black26)
                                              ),
                                            ),
                                            15.horizontalSpace,
                                            Container(
                                              width: 35.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ReusableText(
                                                      text: 'Address:',
                                                      fontSize: 16),
                                                  10.verticalSpace,
                                                  Text(
                                                    orders
                                                        .deliveredOrders[index]
                                                        .address
                                                        .toString(),
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            navigate(orders
                                                .deliveredOrders[index].address
                                                .toNavigateString());
                                          },
                                          child: Container(
                                            width: 40.sp,
                                            height: 26.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: ReusableText(
                                                text: 'Navigate',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}

