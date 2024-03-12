
import 'package:bukizz_delivery/constants/font_family.dart';
import 'package:bukizz_delivery/mvvm/viewModels/Auth/authViewModel.dart';
import 'package:bukizz_delivery/mvvm/views/Auth/Login/reset_password.dart';
import 'package:bukizz_delivery/mvvm/views/NavBar/NavBar.dart';
import 'package:bukizz_delivery/providers/bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/dimensions.dart';
import '../../../../utils/Widgets/buttons/Reusable_Button.dart';
import '../../../../utils/Widgets/containers/Reusable_container.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_TextForm.dart';
import '../../../../utils/Widgets/text and textforms/Reusable_text.dart';
import '../../../../utils/Widgets/text and textforms/signup_text_widget.dart';
import '../SignUp/Signup_Screen.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  static const route = '/signInRoute';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      if (AppConstants.isLogin) {
        context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.route, (route) => false);
      }});
  }
  @override
  Widget build(BuildContext context) {

    //dimension construction
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimensions.width24,
              dimensions.height16,
              dimensions.width24,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //welcome text //done
                ReusableContainer(
                  width: dimensions.width327,
                  height: dimensions.height32,
                  child: () {
                    return ReusableText(
                      text: 'Welcome Back 👋',
                      fontSize: 24,
                      height: 0.06,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.nunito,
                      color: Color(0xFF121212),
                    );
                  },
                ),

                //sign to your account text //done
                ReusableContainer(
                  width: dimensions.width327,
                  height: dimensions.height24,
                  child: () {
                    return ReusableText(
                      text: 'Sign to your account',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA6A6A6),
                    );
                  },
                ),

                //Email text
                ReusableText(
                  text: 'Email',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: dimensions.height10,
                ),
                //Email Form
                ReusableTextField('Your Email', Icons.person_outline, false,
                    _emailTextController),

                SizedBox(
                  height: dimensions.height16,
                ),

                //password text
                ReusableText(
                  text: 'Password',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(
                  height: dimensions.height10,
                ),
                //password form
                ReusableTextField('Your Password', Icons.lock_outline, true,
                    _passwordTextController),

                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPasswordScreen.route);
                    },
                    child: ReusableText(
                      text: "Forget Password ?",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    )),
                //login button
                ReusableElevatedButton(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () async {
                    if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailTextController.text)) {
                      AppConstants.showSnackBar(context, "Enter a valid Email",
                          AppColors.error, Icons.error_outline_rounded);
                      return;
                    }
                    AppConstants.buildShowDialog(context);
                    await context.read<AuthProvider>().signInWithEmailAndPassword(_emailTextController.text, _passwordTextController.text, context);
                  },
                  buttonText: 'Login',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

                SizedBox(
                  height: dimensions.height24*3,
                ),

                signUpOption('Don\'t have an account?', 'Sign Up', context,
                   SignUp.route),

                SizedBox(
                  height: dimensions.height36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//avbqdal;aslmkn
