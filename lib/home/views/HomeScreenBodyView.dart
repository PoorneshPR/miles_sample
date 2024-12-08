import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/common/watch_now_button_ui.dart';
import 'package:miles_sample/home/providers/home_screen_provider.dart';
import 'package:miles_sample/home/views/home_screen_youtube_player.dart';
import 'package:miles_sample/home/views/reel_youtube_player.dart';
import 'package:miles_sample/home/views/video_card.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:miles_sample/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreenBodyView extends StatefulWidget {
  const HomeScreenBodyView({super.key});

  @override
  State<HomeScreenBodyView> createState() => _HomeScreenBodyViewState();
}

class _HomeScreenBodyViewState extends State<HomeScreenBodyView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<HomeScreenProvider>().getHomeScreenData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenProvider, _) {
      {
        switch (homeScreenProvider.loaderState) {
          case LoaderState.initial:
            return const SizedBox.shrink();
            break;
          case LoaderState.loaded:
            return Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: homeScreenProvider
                          .homeScreenDataModel
                          ?.homeScreenResponseData
                          ?.first
                          .homeScreenDataPosts
                          ?.length ??
                      0,
                  itemBuilder: (context, index) {
                    var homeScreenPostData = homeScreenProvider
                        .homeScreenDataModel
                        ?.homeScreenResponseData
                        ?.first
                        .homeScreenDataPosts;
                    String url = homeScreenProvider
                            .homeScreenDataModel
                            ?.homeScreenResponseData
                            ?.first
                            .homeScreenDataPosts?[index]
                            .files
                            ?.first
                            .videoUrl ??
                        "";
                    String result = url
                        .replaceAll("https://youtube.com/shorts/", "")
                        .replaceAll("https://www.youtube.com/shorts/", "");
                    return InkWell(
                        onTap: () async {
                          if (result.isNotEmpty) {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreenYoutubePlayer(
                                    videoId: result,
                                    postListData: homeScreenPostData,
                                    index: index)));
                          }
                          {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                CommonWidgets.customToast(
                                    toastMessage:
                                        "Sorry No videos available currently in this banner..."));
                          }
                        },
                        child: SizedBox(
                          height: 310,
                          width: double.maxFinite,
                          child: Image.network(
                              loadingBuilder: (context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CommonWidgets.smallLoader();
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  CommonWidgets.smallLoader(),
                              fit: BoxFit.fitWidth,
                              homeScreenPostData?[index]
                                      .files
                                      ?.first
                                      .imagePath ??
                                  ""),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                ///United States Widget
                Container(
                  padding: const EdgeInsets.only(
                      top: 32,  bottom:32,right: 4, left: 7),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          "#000000".toColor(),
                          "#0C1F33".toColor(),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.centerLeft,
                      )),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///animation needed /*toDo
                    children: [
                      Text(
                        homeScreenProvider.homeScreenDataModel
                            ?.homeScreenResponseData?[2].heading ??
                            Constants.globalAccount,
                        maxLines: 2,
                        style: FontProperties.headLineSemiBold.copyWith(
                          color: ColorUtils.appTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Container(margin: const EdgeInsets.only(right: 10),
                        height: 1,width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              "#FFA548".toColor(),
                              "#000000".toColor(),
                              "#000000".toColor(),

                            ],
                            begin: Alignment.topRight,
                            end: Alignment.centerLeft,
                          ),
                        ),),
                      Expanded(
                        child: Container(margin: const EdgeInsets.only(left: 20),
                          height: 1,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:  "#FFA548".toColor(),
                          ),),
                      ),
                      Expanded(
                        child: Container(margin: const EdgeInsets.only(left: 20),
                          height: 1,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:  "#FFA548".toColor(),
                          ),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                homeScreenProvider.homeScreenDataModel
                            ?.homeScreenResponseData?[1].blockType ==
                        "reels"
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeScreenProvider
                                .homeScreenDataModel
                                ?.homeScreenResponseData?[1]
                                .homeScreenDataPosts
                                ?.length ??
                            0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, reelIndex) {
                          String url = homeScreenProvider
                                  .homeScreenDataModel
                                  ?.homeScreenResponseData?[1]
                                  .homeScreenDataPosts?[reelIndex]
                                  .files
                                  ?.first
                                  .videoUrl ??
                              "";
                          String result = url;

                          return InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ReelYoutubePlayer(
                                    videoId: result,
                                    reelListData: homeScreenProvider
                                        .homeScreenDataModel
                                        ?.homeScreenResponseData?[1]
                                        .homeScreenDataPosts,
                                    index: reelIndex,
                                  ),
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 13),
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      "#B573F4D5".toColor(),
                                      "#B5FDAC1B".toColor(),
                                      "#B5B839FA".toColor(),
                                      "#B5F752AC".toColor(),
                                      "#B53921FC".toColor()
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: const [0, 0.22, 0.51, 0.77, 0.93],
                                  ),
                                  border: Border.all(width: 2),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(1),
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      SizedBox.expand(
                                        child: Image.network(
                                            loadingBuilder: (context,
                                                Widget child,
                                                ImageChunkEvent?
                                                    loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return CommonWidgets
                                                  .smallLoader();
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    CommonWidgets.smallLoader(),
                                            fit: BoxFit.fitWidth,
                                            homeScreenProvider
                                                    .homeScreenDataModel
                                                    ?.homeScreenResponseData?[1]
                                                    .homeScreenDataPosts?[
                                                        reelIndex]
                                                    .files
                                                    ?.first
                                                    .thumbnail ??
                                                ""),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: WatchNowButton())
                                    ],
                                  ),
                                ),
                              ));
                        })
                    : const SizedBox(),

                ///*/United States Widget
                const SizedBox(
                  height: 38,
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidgets.customToast(
                            toastMessage:
                                "Sorry masterclass will be streamed soon..."));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: Image.network(
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CommonWidgets.smallLoader();
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            CommonWidgets.smallLoader(),
                        fit: BoxFit.fitWidth,
                        homeScreenProvider
                                .homeScreenDataModel
                                ?.homeScreenResponseData?[2]
                                .homeScreenDataPosts
                                ?.first
                                .files
                                ?.first
                                .imagePath ??
                            ""),
                  ),
                ),

        Container(
        padding: const EdgeInsets.only(
        top: 32,  bottom:32,right: 4, left: 7),
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        "#000000".toColor(),
        "#0C1F33".toColor(),
        ],
        begin: Alignment.topRight,
        end: Alignment.centerLeft,
        )),
        child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///animation needed /*toDo
                    children: [
                      Text(
                        homeScreenProvider.homeScreenDataModel
                                ?.homeScreenResponseData?[3].heading ??
                            Constants.globalAccount,
                        maxLines: 2,
                        style: FontProperties.headLineSemiBold.copyWith(
                          color: ColorUtils.appTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Container(margin: const EdgeInsets.only(right: 10),
                        height: 1,width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              "#FFA548".toColor(),
                              "#000000".toColor(),
                              "#000000".toColor(),

                            ],
                            begin: Alignment.topRight,
                            end: Alignment.centerLeft,
                          ),
                        ),),
                      Expanded(
                        child: Container(margin: const EdgeInsets.only(left: 20),
                          height: 1,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:  "#FFA548".toColor(),
                          ),),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidgets.customToast(
                            toastMessage:
                                "Sorry feature will be implemented soon..."));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image.network(
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CommonWidgets.smallLoader();
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            CommonWidgets.smallLoader(),
                        fit: BoxFit.fitWidth,
                        homeScreenProvider
                                .homeScreenDataModel
                                ?.homeScreenResponseData?[3]
                                .homeScreenDataPosts
                                ?.first
                                .files
                                ?.first
                                .imagePath ??
                            ""),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 32,  bottom:32,right: 4, left: 7),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///animation needed /*toDo
                    children: [
                      Text(
                        homeScreenProvider.homeScreenDataModel
                                ?.homeScreenResponseData?[4].heading ??
                            Constants.globalAccount,
                        maxLines: 2,
                        style: FontProperties.headLineSemiBold.copyWith(
                          color: ColorUtils.appTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Container(margin: const EdgeInsets.only(right: 10),
                        height: 1,width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              "#FFA548".toColor(),
                              "#000000".toColor(),
                              "#000000".toColor(),

                            ],
                            begin: Alignment.topRight,
                            end: Alignment.centerLeft,
                          ),
                        ),),
                      Expanded(
                        child: Container(margin: const EdgeInsets.only(left: 20),
                          height: 1,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:  "#FFA548".toColor(),
                          ),),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeScreenProvider
                            .homeScreenDataModel
                            ?.homeScreenResponseData![4]
                            .homeScreenDataPosts
                            ?.length ??
                        0,
                    itemBuilder: (context, milesIndex) {
                      return InkWell(
                        onTap: () async {
                          String result = homeScreenProvider
                                  .homeScreenDataModel
                                  ?.homeScreenResponseData![4]
                                  .homeScreenDataPosts?[milesIndex]
                                  .files
                                  ?.first
                                  .videoUrl ??
                              "";
                          if (result.isNotEmpty) {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreenYoutubePlayer(
                                      videoId: result,
                                      postListData: homeScreenProvider
                                              .homeScreenDataModel
                                              ?.homeScreenResponseData![4]
                                              .homeScreenDataPosts ??
                                          [],
                                      index: milesIndex,
                                    )));
                          }
                        },
                        child: VideoCard(
                          index: milesIndex,
                          homeScreenDataPosts: homeScreenProvider
                                  .homeScreenDataModel
                                  ?.homeScreenResponseData![4]
                                  .homeScreenDataPosts ??
                              [],
                        ),
                      );
                    }),

                Container(
                  padding: const EdgeInsets.only(
                      top: 32,  bottom:32,right: 4, left: 7),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///animation needed /*toDo
                    children: [
                      Text(
                        homeScreenProvider.homeScreenDataModel
                                ?.homeScreenResponseData?[5].heading ??
                            Constants.globalAccount,
                        maxLines: 2,
                        style: FontProperties.headLineSemiBold.copyWith(
                          color: ColorUtils.appTextColor,
                          fontSize: 16,
                        ),
                      ),
                  Container(margin: const EdgeInsets.only(right: 10),
                    height: 1,width: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          "#FFA548".toColor(),
                          "#000000".toColor(),
                          "#000000".toColor(),

                        ],
                        begin: Alignment.topRight,
                        end: Alignment.centerLeft,
                      ),
                    ),),
                  Container(margin: const EdgeInsets.only(right: 10,),
                    height: 1,width: MediaQuery.of(context).size.width*0.2,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color:  "#FFA548".toColor(),
                    ),),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        color:  "#FFA548".toColor(),
                      ),),
                  ),
                    ],
                  ),
                ),
                CarouselSlider.builder(

                  itemCount: homeScreenProvider
                      .homeScreenDataModel
                      ?.homeScreenResponseData?[5]
                      .homeScreenDataPosts
                      ?.length ??
                      0,
                  itemBuilder: (context, carouselIndex, _) {
                    return GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            '${homeScreenProvider.homeScreenDataModel?.homeScreenResponseData?[5].homeScreenDataPosts?.first.blogUrl}');
                        // if (!await launchUrl(url,mode:  LaunchMode.externalApplication,)) {
                        //   print(url);
                        //   throw Exception('Could not launch $url');
                        // }
                      },
                      child:  Container(
                        padding: const EdgeInsets.only(left: 15,top: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              "#000000".toColor(),
                              "#0C1F33".toColor(),
                              "#0C1F33".toColor(),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),

                        child: Image.network(
                            loadingBuilder: (context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CommonWidgets.smallLoader();
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                CommonWidgets.smallLoader(),
                            fit: BoxFit.fitWidth,
                            homeScreenProvider
                                .homeScreenDataModel
                                ?.homeScreenResponseData?[5]
                                .homeScreenDataPosts?[carouselIndex]
                                .files
                                ?.first
                                .imagePath ??
                                ""),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 500,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,pageSnapping: true,disableCenter: true,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 32, bottom: 20, right: 4, left: 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        "#000000".toColor(),
                        "#0C1F33".toColor(),
                        "#0C1F33".toColor(),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    ///animation needed /*toDo
                    children: [
                      const SizedBox(width: 32,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                Constants.flagBearers,
                            maxLines: 2,
                            style: FontProperties.headLineBold.copyWith(fontWeight: FontWeight.w700,
                              color: "#DDEEFF".toColor(),
                              fontSize: 24,
                            ),
                          ),
                          Text(
                                Constants.accountants,
                            maxLines: 2,
                            style: FontProperties.headLineBold.copyWith(fontWeight: FontWeight.w700,
                              color:  "#DDEEFF".toColor(),
                              fontSize: 36,
                            ),
                          ),
                          Text(
                                Constants.created,
                            maxLines: 2,
                            style: FontProperties.headLineNormal.copyWith(fontWeight: FontWeight.w300,
                              color:  "#D5DBE2".toColor(),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 30,)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80,)



              ],
            );

            break;
          case LoaderState.loading:
            return Center(child: CommonWidgets.smallLoader());
            break;
          case LoaderState.error:
            return Center(
              child: Text(
                Constants.error,
                maxLines: 2,
                style: FontProperties.headLineNormal.copyWith(
                  color: ColorUtils.appTextColor,
                  fontSize: 16,
                ),
              ),
            );

          case LoaderState.noData:
            return Center(
              child: Text(
                Constants.user,
                maxLines: 2,
                style: FontProperties.headLineNormal.copyWith(
                  color: ColorUtils.appTextColor,
                  fontSize: 16,
                ),
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      }
    });
  }
}
