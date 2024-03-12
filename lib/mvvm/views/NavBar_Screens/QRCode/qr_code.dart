import 'dart:math';

import 'package:bukizz_delivery/constants/dimensions.dart';
import 'package:bukizz_delivery/constants/strings.dart';
import 'package:bukizz_delivery/mvvm/viewModels/orders/orders.dart';
import 'package:bukizz_delivery/providers/bottom_nav_bar_provider.dart';
import 'package:bukizz_delivery/utils/Widgets/spacing/spacing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_text.dart';
import '../../../models/notifications/notifications.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  late final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  Barcode? _barcode;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      showCustomAboutDialog(context , barcode);
      _controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: dimensions.screenWidth,
            height: dimensions.screenHeight,
            child:  QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Center(
            child: _buildQRIndicator(),
          )
        ],
      )
    );
  }

  Widget _buildQRIndicator() {
    return DottedBorder(
      dashPattern: [34.5.sp,50.sp,50.sp,50.sp,50.sp,50.sp,50.sp,50.sp],
      color: Colors.white,
      radius: Radius.circular(10),
      child: Container(
        height: 70.sp,
        width: 70.sp,
      ),
    );
  }


}

void showCustomAboutDialog(BuildContext context  , Barcode barcode) {
  Dimensions dimensions=Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
          title: Center(
            child: Column(
              children: [
                ReusableText(text: 'Are You ready to pack this order', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
                SizedBox(height: dimensions.height10*2,),
                const SizedBox(
                  width: 294,
                  child: Text(
                    'Please ensure all items are checked and ready for shipment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
                      child: ReusableText(text: 'Cancel', fontSize: 14,fontWeight: FontWeight.w600, color: Color(0xFF00579E),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    int otp = Random().nextInt(999999);
                    FirebaseFirestore.instance.collection('orderDetails').doc(barcode.code).update({
                      'status':'Out For Delivery'
                    }).then((value) {
                      FirebaseFirestore.instance.collection(AppString.collectionDelivery).doc(AppConstants.userData.id).update({
                        'pendingDelivery': FieldValue.arrayUnion([barcode.code]),
                      }).then((value) => FirebaseDatabase.instance.ref().child('ordersOTP').child(barcode.code!).set(otp)).then((value){
                        //get the userId from the orderId and send notification
                        FirebaseFirestore.instance.collection('orderDetails').doc(barcode.code).get().then((value) {
                          String userId = value.data()!['userId'];
                          NotificationModel notificationModel = NotificationModel(
                            navInit: 'Your Order is',
                            navLast: 'Out For Delivery',
                            content: 'Your product ${value.data()!['productName']} - ${value.data()!['schoolName']} is Out For Delivery having code $otp',
                            image: value.data()!['image'][0],
                            date: DateTime.now().toIso8601String(),
                            notificationId: '1',
                            link: '/order/${barcode.code}',
                          );
                          context.read<Orders>().sendNotification(notificationModel, userId);
                        });
                      }).then((value){
                        Navigator.of(context).pop();
                        context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
                      });
                    }).catchError((e){
                      AppConstants.showSnackBar(context, e.toString(), AppColors.error, Icons.error_outline_rounded);
                    });
                  },
                  child: Container(
                    width: dimensions.width10*11.5,
                    height: dimensions.height10*3.5,
                    decoration: ShapeDecoration(
                      color: Color(0xFF058FFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: ReusableText(text: 'Accept', fontSize: 14,fontWeight: FontWeight.w600, color:Colors.white,),
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
