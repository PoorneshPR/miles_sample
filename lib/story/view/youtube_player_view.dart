import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/story/models/story_model.dart';
import 'package:miles_sample/story/providers/story_provider.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerViewScreen extends StatefulWidget {
  const YoutubePlayerViewScreen(
      {super.key,
      required this.videoId,
      required this.storyListData,
      required this.index});

  final String videoId;
  final List<StoryListData>? storyListData;
  final int index;

  @override
  State<YoutubePlayerViewScreen> createState() =>
      _YoutubePlayerViewScreenState();
}

class _YoutubePlayerViewScreenState extends State<YoutubePlayerViewScreen> {
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

    id = widget.videoId ?? "";
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
        .read<StoryProvider>()
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

  void checkIsWatched({required StoryListData? storyListData}) {
    storyListData?.watched=true;
    context.read<StoryProvider>().storyAlreadyWatched(
        isWatched: storyListData?.watched ?? false, index: widget.index);
  }

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
                thumbnail: (widget.storyListData?[widget.index].imageUrl ?? "")
                        .isNotEmpty
                    ?  Image.network(
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
                        widget.storyListData?[widget.index].imageUrl ?? "")
                    : SvgPicture.asset(Assets.iconsMilesLogo),
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,

                liveUIColor: Colors.red,

                onReady: () {
                  _isPlayerReady = true;
                 checkIsWatched(storyListData: widget.storyListData?[widget.index]);
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
                child: Consumer<StoryProvider>(builder: (context, snapshot, _) {
                  var storyData = snapshot.storyModel?.data?[widget.index];
                  return Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          (storyData?.likedByMe ?? false)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (storyData?.likedByMe ?? false)
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
                        (storyData?.likes ?? 0).toString() ?? "",
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
