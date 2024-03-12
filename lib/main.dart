import 'package:bukizz_delivery/mvvm/models/userModel/userModel.dart';
import 'package:bukizz_delivery/mvvm/views/Auth/Login/Signin_Screen.dart';
import 'package:bukizz_delivery/providers/provider.dart';
import 'package:bukizz_delivery/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserModel.loadFromSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      return ResponsiveSizer(builder: (context, orientation, screenType){
        return MultiProvider(
            providers: providers,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: SignIn.route,
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: AppTheme.lightThemeData,
            ));
      });
    }
  }


