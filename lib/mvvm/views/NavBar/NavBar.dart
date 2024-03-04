
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            items:<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.homeIcon,color: context.watch<BottomNavigationBarProvider>().selectedIndex == 0 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.cartIcon, color: context.watch<BottomNavigationBarProvider>().selectedIndex == 1 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.notificationIcon,color: context.watch<BottomNavigationBarProvider>().selectedIndex == 2 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                label: 'Notification',

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
        return Container();
      case 1:
        return  Container();
      case 2:
        return  Container();
      default:
        return Container();
    }
  }
}

