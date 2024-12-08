import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miles_sample/generated/assets.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SvgPicture.asset(Assets.iconsNotificationsBell,
      width: 30,
      height: 30,),
    );
  }
}
