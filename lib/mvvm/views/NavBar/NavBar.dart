
import 'package:bukizz_delivery/mvvm/views/NavBar_Screens/Delivery_screen.dart';
import 'package:bukizz_delivery/mvvm/views/NavBar_Screens/QRCode/qr_code.dart';
import 'package:bukizz_delivery/mvvm/views/profile/newProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../providers/bottom_nav_bar_provider.dart';




class MainScreen extends StatefulWidget {
  static const String route = '/mainscreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(builder: (context , bottomProvider , child){
      return Scaffold(
          body: _buildCurrentScreen(),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining),
                label: 'Delivery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            unselectedItemColor: AppColors.schoolTextColor,
            unselectedFontSize: 10,
            selectedFontSize: 12,
            selectedItemColor: AppColors.productButtonSelectedBorder,
            currentIndex: bottomProvider.selectedIndex,
            showUnselectedLabels: true,
            onTap: bottomProvider.setSelectedIndex,
            type: BottomNavigationBarType.fixed,
          )
      );
    },);
  }


  Widget _buildCurrentScreen() {
    switch (context.watch<BottomNavigationBarProvider>().selectedIndex) {
      case 0:
        return QRCodeScanner();
      case 1:
        return  Delivery_Screen();
      case 2:
        return  NewProfileScreen();
      default:
        return Container();
    }
  }
}

