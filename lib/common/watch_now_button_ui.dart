import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';

class WatchNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(height: 24,width: 84,

      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      // Slight white background for blur effect
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4), // Rounded corners for blur
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 9), // Blur effect
          child:Row(mainAxisSize: MainAxisSize.min,

              children: [
                Icon(
                  Icons.play_arrow,
                  color: "#99CCFF".toColor(),
                  size: 15,
                ),
                const SizedBox(width: 8,),

                Text(
                  "Watch Now",
                  style: TextStyle(
                    color: "#99CCFF".toColor(), // Text color
                    fontSize: 8, // Font size as per your original code
                    fontWeight: FontWeight.w500, // Font weight
                    shadows: [
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.8), // Light shadow for better readability
                      ),
                    ],
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }
}
