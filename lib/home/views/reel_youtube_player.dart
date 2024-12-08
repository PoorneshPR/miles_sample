import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/models/HomeScreenModel.dart';
import 'package:miles_sample/home/providers/home_screen_provider.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelYoutubePlayer extends StatefulWidget {
  const ReelYoutubePlayer(
      {super.key,
        required this.videoId,
        required this.reelListData,
        required this.index});

  final String videoId;
  final List<HomeScreenDataPosts>? reelListData;
  final int index;

  @override
  State<ReelYoutubePlayer> createState() =>
      _ReelYoutubePlayerState();
}

class _ReelYoutubePlayerState extends State<ReelYoutubePlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  bool isLikedLocal = false;

  late String id;

  @override
  void initState() {
    super.initState();

    id = YoutubePlayer.convertUrlToId(widget.videoId ?? "")!;
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void toggleLike() {
    context
        .read<HomeScreenProvider>()
        .gettingLike(isLiked: isLikedLocal, index: widget.index);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  // void checkIsWatched({required List<Posts>? post}) {
  //   storyListData?.watched=true;
  //   context.read<StoryProvider>().storyAlreadyWatched(
  //       isWatched: storyListData?.watched ?? false, index: widget.index);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: YoutubePlayerBuilder(
              onExitFullScreen: () {
                // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              },
              player: YoutubePlayer(
                controlsTimeOut: const Duration(seconds: 5),
                width: double.infinity,
                thumbnail: (widget.reelListData?[widget.index].files?.first.thumbnail ?? "")
                    .isNotEmpty
                    ? Image.network(
                    loadingBuilder: (context,
                        Widget child,
                        ImageChunkEvent?
                        loadingProgress) {
                      if (loadingProgress == null)
                        return child;
                      return CommonWidgets
                          .smallLoader();
                    },
                    errorBuilder:
                        (context, error, stackTrace) =>
                        CommonWidgets.smallLoader(),
                    fit: BoxFit.fitWidth,
                    widget.reelListData?[widget.index].files?.first.videoUrl ?? "")
                    : SvgPicture.asset(Assets.iconsMilesLogo),
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,

                liveUIColor: Colors.red,

                onReady: () {
                  _isPlayerReady = true;
                  // checkIsWatched(storyListData: widget.reelListData?[widget.index]);
                },
                onEnded: (data) {
                  Navigator.pop(context);
                },
              ),
              builder: (context, player) =>player),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: Consumer<HomeScreenProvider>(builder: (context, snapshot, _) {
                  var reelPostData = snapshot.homeScreenDataModel?.homeScreenResponseData?[1].homeScreenDataPosts?[widget.index];
                  return Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          (reelPostData?.likedByMe ?? false)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (reelPostData?.likedByMe ?? false)
                              ? Colors.red
                              : Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          isLikedLocal = !isLikedLocal;
                          toggleLike();
                        },
                      ),
                      Text(
                        (reelPostData?.likes ?? 0).toString() ?? "",
                        style: FontProperties.headLineNormal.copyWith(
                          color: ColorUtils.appTextColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: IconButton(
                  icon: SvgPicture.asset(
                    Assets.iconsShareLogo,
                    height: 30,
                    width: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
