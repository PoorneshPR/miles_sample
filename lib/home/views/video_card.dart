import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/models/HomeScreenModel.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:miles_sample/utils/animated_gradient_circle.dart';

class VideoCard extends StatelessWidget {

  const VideoCard({required this.homeScreenDataPosts, required this.index});

  final List<HomeScreenDataPosts> homeScreenDataPosts;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            "#000000".toColor(),
            "#0C1F33".toColor(),
          ],
          begin: Alignment.topRight,
          end: Alignment.centerLeft,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10, top: 15, left: 5, right: 5),
      margin: const EdgeInsets.only(bottom: 5,left: 2),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  "#2F3942CC".toColor(),
                  "#000B16CC".toColor(),
                ],
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: Image.network(
             homeScreenDataPosts[index].files?.first.thumbnail?? "",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  "#000000".toColor(),
                  "#0C1F33".toColor(),
                ],
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
              ),
            ),
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedGradientCircle(
                      isWatched: false,
                      size: 55,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(Assets.iconsMilesLogoBlue,

                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox( width:200,
                          child: Text(
                            homeScreenDataPosts[index].title??"",
                            maxLines: 5,
                            style: FontProperties.headLineNormal.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "6.5 Likes",
                          style: FontProperties.headLineNormal.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: "#606060".toColor()),
                        ),
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
