import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:miles_sample/common/common_app_bar.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/models/HomeScreenModel.dart';
import 'package:miles_sample/home/providers/home_screen_provider.dart';
import 'package:miles_sample/home/views/HomeScreenBodyView.dart';
import 'package:miles_sample/story/models/story_model.dart';
import 'package:miles_sample/story/providers/story_provider.dart';
import 'package:miles_sample/story/view/youtube_player_view.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:miles_sample/utils/animated_gradient_circle.dart';
import 'package:miles_sample/utils/constants.dart';
import 'package:miles_sample/utils/grid_background.dart';
import 'package:provider/provider.dart';

class MilesHomeScreen extends StatefulWidget {
  const MilesHomeScreen({super.key});

  @override
  State<MilesHomeScreen> createState() => _MilesHomeScreenState();
}

class _MilesHomeScreenState extends State<MilesHomeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<StoryProvider>().getViewStory();
    });
    // TODO: implement initState
    super.initState();
  }
  Future<void> _handleRefresh() async {
    StoryProvider storyProvider =context.read<StoryProvider>();
    HomeScreenProvider homeScreenProvider = context.read<HomeScreenProvider>();
     storyProvider.storyModel=StoryModel();
     homeScreenProvider.homeScreenDataModel=HomeScreenDataModel();
     await storyProvider.getViewStory();
     await homeScreenProvider.getHomeScreenData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(width: 300,height: 100,
        decoration:BoxDecoration(color:"#020815CC".toColor(), borderRadius: BorderRadius.circular(90)
       ),
        child: ClipRRect(clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.only(
                topRight: Radius.circular(60),
                topLeft: Radius.circular(60),

              ),
          child: Column(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 9),
                child:  BottomNavigationBar(
                      items: <BottomNavigationBarItem>[

                        BottomNavigationBarItem(
                            backgroundColor: "#020815CC".toColor(),
                            activeIcon: SvgPicture.asset(
                              Assets.iconsHomeBottom,
                            ),
                            icon: SvgPicture.asset(
                              Assets.iconsHomeBottom,color: Colors.grey,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              Assets.iconsReelBottom,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.iconsTorch,
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10),
                            child: SvgPicture.asset(
                              Assets.iconsCalendarMonth,
                            ),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.iconsPerson,
                          ),
                          label: '',
                        ),
                      ],
                      currentIndex: 0,
                      selectedItemColor: Colors.white,
                    ),
              ),Container(width: 200,
                color: "#020412CC".toColor(),
                alignment: Alignment.bottomCenter,

                child:Text(
                  "Home",
                  maxLines: 2,
                  style: FontProperties.headLineNormal.copyWith(fontWeight: FontWeight.w300,
                    color:  "#D5DBE2".toColor(),
                    fontSize: 14,
                  ),
                ),),

            ],
          ),
        ),
      ),
      appBar: AppBar(  iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Your custom logic to open the drawer, if needed
            // Example: Scaffold.of(context).openDrawer();
          },
        ),
        centerTitle: true,
        title: SizedBox(
            child: SvgPicture.asset(
          Assets.iconsMilesLogo,
          height: 28,
          width: 58,
          fit: BoxFit.fill,
        )),
        actions: const [CommonAppBar()],
      ),

      body: Stack(
        children: [
          GridBackground(),
          RefreshIndicator(strokeWidth: 1,
            onRefresh:(){

              return  _handleRefresh();},
            color: Colors.white,
            backgroundColor: Colors.blue,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                CommonWidgets.goodMorningHomeWidget(context:context),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  height: 110,
                  child: Consumer<StoryProvider>(
                      builder: (context, storyProvider, _) {
                    switch (storyProvider.loaderState) {
                      case LoaderState.initial:
                        return const SizedBox.shrink();
                        break;
                      case LoaderState.loaded:
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: storyProvider.storyModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            String url =
                                storyProvider.storyModel?.data?[index].videoUrl ??
                                    "";
                            String result = url
                                .replaceAll("https://youtube.com/shorts/", "")
                                .replaceAll(
                                    "https://www.youtube.com/shorts/", "");
                            return InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => YoutubePlayerViewScreen(
                                    videoId: result,
                                    storyListData: storyProvider.storyModel?.data,
                                    index: index,
                                  ),
                                ));
                              },
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      AnimatedGradientCircle(
                                        isWatched: storyProvider.storyModel
                                                ?.data?[index].watched ??
                                            false,
                                        size: (storyProvider.storyModel
                                                    ?.data?[index].watched ??
                                                false)
                                            ? 80
                                            : 70,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(70),
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                              0,
                                            ),
                                            child: Image.network(
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    Assets.imagesUnknownUser);
                                              },
                                              loadingBuilder: (context,
                                                  Widget child,
                                                  ImageChunkEvent?
                                                      loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }

                                                return Stack(
                                                  children: [
                                                    Center(
                                                        child: CommonWidgets
                                                            .smallLoader()),
                                                    child,
                                                  ],
                                                );
                                              },
                                              storyProvider.storyModel
                                                      ?.data?[index].imageUrl ??
                                                  "",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    storyProvider
                                            .storyModel?.data?[index].firstName ??
                                        "",
                                    style: FontProperties.headLineNormal.copyWith(
                                      color: ColorUtils.appTextColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
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
                  }),
                ),
                const SizedBox(
                  height: 5,
                ),
                const HomeScreenBodyView()
              ]),
            ),
          ),
        ],
      ),
    );
  }

}
