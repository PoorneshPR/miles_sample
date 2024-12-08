import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/views/miles_home_screen.dart';
import 'package:miles_sample/utils/grid_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToHome();
  }

  goToHome() async {
    Future.delayed(const Duration(seconds: 2), () {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MilesHomeScreen(),));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GridBackground(),
          Center(
            child: SvgPicture.asset(
              Assets.iconsMilesLogo,
              height: 50,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
